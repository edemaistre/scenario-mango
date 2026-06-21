#!/bin/bash
# v5 hero sizzle reel (9:16, 1080x1920, ~30s), jumpsuit-anchored, VIDEO ONLY (no stills).
# Acts: title -> "one garment, every face" (S2 on M1..M5) -> "one face, every look" (M1 in S2/S6/C7) -> lifestyle -> CTA.
# Only uses surviving loop_*.mp4 clips (all 720x1280, clean 9:16, no squish). Text = pre-rendered PNG overlays. No em dashes.
# TODO (gated): Act 3 "one face, one look, every environment" = GPT Image 2 variations -> Seedance clips; + ElevenLabs music.
set -e
cd "$(dirname "$0")/.."          # -> la-redoute-pitch/
R=reel; T=$R/hero; OV=$T/ov; S=$T/seg; mkdir -p "$OV" "$S"
V=media/video
LOGOW=media/scenario-logo-white.png
AB="/System/Library/Fonts/Supplemental/Arial Bold.ttf"
AR="/System/Library/Fonts/Supplemental/Arial.ttf"
SER="/System/Library/Fonts/Supplemental/Georgia Bold.ttf"; [ -f "$SER" ] || SER="$AB"
enc=(-c:v libx264 -pix_fmt yuv420p -r 30 -preset medium -crf 19)
TAG="AI on-model  ·  AI faces"

# ---- title/CTA card with logo ----
card(){ # out kicker big1 big2 sub
  magick -size 1080x1920 xc:'#141418' \
    \( "$LOGOW" -resize 380x \) -gravity north -geometry +0+360 -composite \
    -font "$AB" -fill '#9a9aa2' -pointsize 26 -gravity north -annotate +0+640 "$2" \
    -font "$SER" -fill white -pointsize 104 -gravity center -annotate +0-30 "$3" \
    -font "$SER" -fill white -pointsize 104 -gravity center -annotate +0+90 "$4" \
    -font "$AR" -fill '#c8c8cf' -pointsize 34 -gravity south -annotate +0+470 "$5" "$1"; }
# ---- opening TITLE as an overlay on a live model clip (so frame 1 is a model + garment, not a black card) ----
titleov(){ # out
  magick -size 1080x1920 xc:none \
    \( -size 1080x780 gradient:none-'rgba(8,8,12,0.88)' \) -gravity south -compose over -composite \
    \( "$LOGOW" -resize 300x \) -gravity southwest -geometry +56+372 -composite \
    -font "$SER" -fill white -pointsize 80 -gravity southwest -annotate +54+236 "One packshot." \
    -font "$SER" -fill white -pointsize 80 -gravity southwest -annotate +54+142 "A full campaign." \
    -font "$AR" -fill '#e8e8ee' -pointsize 30 -gravity southwest -annotate +56+92 "On-model, in motion, in any market. Minutes, not weeks." \
    -font "$AR" -fill 'rgba(255,255,255,0.92)' -pointsize 24 -gravity northeast -annotate +40+40 "$TAG" "$1"; }
# ---- section divider card (no logo) ----
scard(){ # out kicker line1 line2
  magick -size 1080x1920 xc:'#141418' \
    -font "$AB" -fill '#9a9aa2' -pointsize 27 -gravity center -annotate +0-180 "$2" \
    -font "$SER" -fill white -pointsize 100 -gravity center -annotate +0-30 "$3" \
    -font "$SER" -fill white -pointsize 100 -gravity center -annotate +0+90 "$4" "$1"; }
# ---- lower-third overlay (transparent full-frame) ----
lt(){ # out line1 line2
  magick -size 1080x1920 xc:none \
    \( -size 1080x320 gradient:none-'rgba(8,8,12,0.82)' \) -gravity south -compose over -composite \
    -font "$AB" -fill white -pointsize 46 -gravity southwest -annotate +56+100 "$2" \
    -font "$AR" -fill '#e8e8ee' -pointsize 31 -gravity southwest -annotate +56+52 "$3" \
    -font "$AR" -fill 'rgba(255,255,255,0.92)' -pointsize 24 -gravity northeast -annotate +40+40 "$TAG" "$1"; }

clipseg(){ # clip overlay dur out  (9:16 clip, cover+crop, no squish)
  ffmpeg -y -loglevel error -i "$1" -i "$2" -filter_complex \
   "[0:v]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,fps=30,setsar=1[v];[v][1:v]overlay=0:0,trim=duration=$3,setpts=PTS-STARTPTS[o]" -map "[o]" -an "${enc[@]}" "$4"; }
cardseg(){ ffmpeg -y -loglevel error -loop 1 -t "$2" -i "$1" -vf "scale=1080:1920,setsar=1,fps=30" "${enc[@]}" "$3"; }

echo "== overlays =="
titleov "$OV/title.png"
card  "$T/c_cta.png"   "FROM ONE PACKSHOT"          "Infinite"      "on-model content." "Book the working session  ·  scenario.com"
scard "$T/s_face.png"  "PROOF 1"  "One garment,"  "every face."
scard "$T/s_look.png"  "PROOF 2"  "One face,"     "every look."
lt "$OV/m1.png" "Sofia" "Spanish  ·  same garment, no re-shoot"
lt "$OV/m2.png" "Mei"   "East Asian  ·  same garment, no re-shoot"
lt "$OV/m3.png" "Amara" "Black  ·  same garment, no re-shoot"
lt "$OV/m4.png" "Elin"  "Northern European  ·  same garment, no re-shoot"
lt "$OV/m5.png" "Priya" "South Asian  ·  same garment, no re-shoot"
lt "$OV/l_s2.png" "Combinaison florale" "Mango  ·  49,99 €  ·  same model"
lt "$OV/l_s6.png" "Robe à fleurs cut-out" "Mango  ·  79,99 €  ·  same model"
lt "$OV/l_c7.png" "Chemise + pantalon lin" "Mango  ·  89,98 €  ·  same model"
lt "$OV/life.png" "Lifestyle  ·  Paris" "Same garment, AI environment"

echo "== segments =="
clipseg "$V/loop_S2_M3.mp4" "$OV/title.png" 3.4 "$S/00.mp4"
cardseg "$T/s_face.png"  1.5 "$S/01.mp4"
clipseg "$V/loop_S2_M1.mp4" "$OV/m1.png" 2.0 "$S/02.mp4"
clipseg "$V/loop_S2_M2.mp4" "$OV/m2.png" 2.0 "$S/03.mp4"
clipseg "$V/loop_S2_M3.mp4" "$OV/m3.png" 2.0 "$S/04.mp4"
clipseg "$V/loop_S2_M4.mp4" "$OV/m4.png" 2.0 "$S/05.mp4"
clipseg "$V/loop_S2_M5.mp4" "$OV/m5.png" 2.0 "$S/06.mp4"
cardseg "$T/s_look.png"  1.5 "$S/07.mp4"
clipseg "$V/loop_M1_S2.mp4" "$OV/l_s2.png" 2.2 "$S/08.mp4"
clipseg "$V/loop_M1_S6.mp4" "$OV/l_s6.png" 2.2 "$S/09.mp4"
clipseg "$V/loop_M1_C7.mp4" "$OV/l_c7.png" 2.2 "$S/10.mp4"
clipseg "$V/loop_S2_life.mp4" "$OV/life.png" 3.6 "$S/11.mp4"
cardseg "$T/c_cta.png" 4.0 "$S/12.mp4"

echo "== concat =="
: > "$T/list.txt"; for f in 00 01 02 03 04 05 06 07 08 09 10 11 12; do echo "file 'seg/$f.mp4'" >> "$T/list.txt"; done
ffmpeg -y -loglevel error -f concat -safe 0 -i "$T/list.txt" -c copy "$T/silent.mp4"
DUR=$(ffprobe -v error -show_entries format=duration -of default=nk=1:nw=1 "$T/silent.mp4"); echo "silent: ${DUR}s"
FO=$(echo "$DUR-1.4" | bc)

echo "== mux music (interim: media/audio/bed.mp3 until ElevenLabs track lands) =="
ffmpeg -y -loglevel error -i "$T/silent.mp4" -i media/audio/bed.mp3 -filter_complex \
 "[1:a]afade=t=in:st=0:d=0.8,afade=t=out:st=$FO:d=1.4,loudnorm=I=-16:TP=-1.5:LRA=11[a]" \
 -map 0:v -map "[a]" -c:v copy -c:a aac -b:a 192k -shortest "media/video/sizzle_9x16.mp4"

echo "== 16:9 letterbox variant =="
ffmpeg -y -loglevel error -i "media/video/sizzle_9x16.mp4" -vf \
 "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:color=#141418,setsar=1" \
 -c:v libx264 -pix_fmt yuv420p -crf 20 -c:a copy "media/video/sizzle_16x9.mp4"

rm -rf "$S"
echo "DONE"; for f in sizzle_9x16 sizzle_16x9; do
  echo "$f: $(ffprobe -v error -show_entries format=duration -of default=nk=1:nw=1 media/video/$f.mp4)s $(ls -la media/video/$f.mp4|awk '{print $5}')b"; done
