#!/bin/bash
# Builds the music-backed sizzle reel (9:16, 1080x1920). No drawtext (this ffmpeg lacks it):
# all text is pre-rendered PNG overlays composited via overlay/concat.
set -e
cd "$(dirname "$0")/.."   # -> la-redoute-pitch/
R=reel; S=$R/seg; mkdir -p "$S"
V=media/video; C=media/ceiling; OV=$R/ov
enc=(-c:v libx264 -pix_fmt yuv420p -r 30 -preset medium -crf 19)

# --- card from still image (loop N sec) ---
card(){ # img dur out
  ffmpeg -y -loglevel error -loop 1 -i "$1" -t "$2" -vf "scale=1080:1920,setsar=1,fps=30" "${enc[@]}" "$3"
}
# --- studio clip + overlay, trimmed ---
clipseg(){ # clip overlay dur out
  ffmpeg -y -loglevel error -i "$1" -i "$2" -filter_complex \
   "[0:v]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,fps=30,setsar=1[v];[v][1:v]overlay=0:0,trim=duration=$3,setpts=PTS-STARTPTS[o]" \
   -map "[o]" -an "${enc[@]}" "$4"
}
# --- lifestyle motion clip + overlay (full duration) ---
lifeseg(){ # clip overlay out
  ffmpeg -y -loglevel error -i "$1" -i "$2" -filter_complex \
   "[0:v]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,fps=30,setsar=1[v];[v][1:v]overlay=0:0[o]" \
   -map "[o]" -an "${enc[@]}" "$3"
}
# --- ken-burns still + overlay ---
kbseg(){ # still overlay dur out
  local frames=$(echo "$3*30/1" | bc)
  ffmpeg -y -loglevel error -loop 1 -i "$1" -i "$2" -filter_complex \
   "[0:v]scale=1296:2304,zoompan=z='min(zoom+0.0008,1.12)':d=$frames:fps=30:s=1080x1920:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)',setsar=1,trim=duration=$3[v];[v][1:v]overlay=0:0[o]" \
   -map "[o]" -an "${enc[@]}" "$4"
}

echo "building segments..."
card "$R/title.png" 3 "$S/00_title.mp4"
clipseg "$V/turn_M1_red_satin.mp4" "$OV/c1.png" 2.2 "$S/01.mp4"
clipseg "$V/turn_M2_pink.mp4"      "$OV/c2.png" 2.2 "$S/02.mp4"
clipseg "$V/turn_M3_jumpsuit.mp4"  "$OV/c3.png" 2.2 "$S/03.mp4"
clipseg "$V/turn_M4_linen.mp4"     "$OV/c4.png" 2.2 "$S/04.mp4"
clipseg "$V/turn_M5_orange.mp4"    "$OV/c5.png" 2.2 "$S/05.mp4"
lifeseg "$V/life_terrace.mp4"      "$OV/ceiling.png" "$S/06_life.mp4"
kbseg   "$C/S2_M3_boutique.jpg"    "$OV/ceiling.png" 2.6 "$S/07.mp4"
kbseg   "$C/C7_M4_cafe.jpg"        "$OV/ceiling.png" 2.6 "$S/08.mp4"
kbseg   "$C/S6_M5_gallery.jpg"     "$OV/ceiling.png" 2.6 "$S/09.mp4"
card "$R/cta.png" 4 "$S/10_cta.mp4"

echo "concat..."
: > "$S/list.txt"
for f in 00_title 01 02 03 04 05 06_life 07 08 09 10_cta; do echo "file 'seg/$f.mp4'" >> "$S/list.txt"; done
ffmpeg -y -loglevel error -f concat -safe 0 -i "$S/list.txt" -c copy "$R/reel_silent.mp4"
DUR=$(ffprobe -v error -show_entries format=duration -of default=nk=1:nw=1 "$R/reel_silent.mp4")
echo "silent reel duration: $DUR"
FO=$(echo "$DUR-1.4" | bc)

echo "muxing music..."
ffmpeg -y -loglevel error -i "$R/reel_silent.mp4" -i media/audio/bed.mp3 -filter_complex \
 "[1:a]afade=t=in:st=0:d=0.8,afade=t=out:st=$FO:d=1.4,loudnorm=I=-16:TP=-1.5:LRA=11[a]" \
 -map 0:v -map "[a]" -c:v copy -c:a aac -b:a 192k -shortest "media/video/sizzle_9x16.mp4"

echo "16:9 letterbox variant..."
ffmpeg -y -loglevel error -i "media/video/sizzle_9x16.mp4" -vf \
 "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:color=#141418,setsar=1" \
 -c:v libx264 -pix_fmt yuv420p -crf 20 -c:a copy "media/video/sizzle_16x9.mp4"

# hero poster frame for site/deck (a strong editorial frame)
cp media/ceiling/S4_M3_paris.jpg media/hero_lifestyle.jpg
echo "DONE"; ls -la media/video/sizzle_*.mp4 | awk '{print $5,$9}'
ffprobe -v error -show_entries format=duration -of default=nk=1:nw=1 "media/video/sizzle_9x16.mp4"
