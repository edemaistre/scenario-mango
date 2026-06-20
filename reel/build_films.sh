#!/bin/bash
# Builds 3 purpose-built 9:16 films. Stills use blurred-fill (NO squeeze). Text = PNG overlays (no drawtext).
set -e
cd "$(dirname "$0")/.."          # -> la-redoute-pitch/
R=reel; T=$R/films; OV=$T/ov; mkdir -p "$T/seg" "$OV"
V=media/video; L=media/looks; C=media/ceiling; AB="/System/Library/Fonts/Supplemental/Arial Bold.ttf"; AR="/System/Library/Fonts/Supplemental/Arial.ttf"
enc=(-c:v libx264 -pix_fmt yuv420p -r 30 -preset medium -crf 19)
TAG="AI on-model  ·  AI faces"

# ---- text asset makers ----
card(){ # out kicker big1 big2 sub
  magick -size 1080x1920 xc:'#141418' \
    -font "$AB" -fill '#9a9aa2' -pointsize 26 -gravity north -annotate +0+560 "$2" \
    -font "$AB" -fill white -pointsize 104 -gravity center -annotate +0-40 "$3" \
    -font "$AB" -fill white -pointsize 104 -gravity center -annotate +0+78 "$4" \
    -font "$AR" -fill '#c8c8cf' -pointsize 32 -gravity south -annotate +0+470 "$5" "$1"; }
lt(){ # out line1 line2  (transparent full-frame, bottom bar + corner tag)
  magick -size 1080x1920 xc:none \
    \( -size 1080x300 gradient:none-'rgba(8,8,12,0.8)' \) -gravity south -compose over -composite \
    -font "$AB" -fill white -pointsize 44 -gravity southwest -annotate +52+96 "$2" \
    -font "$AR" -fill '#e6e6ec' -pointsize 30 -gravity southwest -annotate +52+50 "$3" \
    -font "$AR" -fill 'rgba(255,255,255,0.92)' -pointsize 24 -gravity northeast -annotate +36+36 "$TAG" "$1"; }

clipseg(){ # clip overlay dur out
  ffmpeg -y -loglevel error -i "$1" -i "$2" -filter_complex \
   "[0:v]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,fps=30,setsar=1[v];[v][1:v]overlay=0:0,trim=duration=$3,setpts=PTS-STARTPTS[o]" -map "[o]" -an "${enc[@]}" "$4"; }
stillseg(){ # still overlay dur out  (blurred fill, NO squeeze)
  ffmpeg -y -loglevel error -loop 1 -t "$3" -i "$1" -i "$2" -filter_complex \
   "[0:v]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,boxblur=30:2,eq=brightness=-0.14[bg];[0:v]scale=1080:1920:force_original_aspect_ratio=decrease[fg];[bg][fg]overlay=(W-w)/2:(H-h)/2[bse];[bse][1:v]overlay=0:0,fps=30,setsar=1[o]" -map "[o]" -an "${enc[@]}" "$4"; }
cardseg(){ ffmpeg -y -loglevel error -loop 1 -t "$2" -i "$1" -vf "scale=1080:1920,setsar=1,fps=30" "${enc[@]}" "$3"; }

mux(){ # silent_in out
  local dur fo; dur=$(ffprobe -v error -show_entries format=duration -of default=nk=1:nw=1 "$1"); fo=$(echo "$dur-1.3"|bc)
  ffmpeg -y -loglevel error -i "$1" -i media/audio/bed.mp3 -filter_complex \
   "[1:a]afade=t=in:st=0:d=0.6,afade=t=out:st=$fo:d=1.3,loudnorm=I=-16:TP=-1.5:LRA=11[a]" \
   -map 0:v -map "[a]" -c:v copy -c:a aac -b:a 192k -shortest "$2"; }

concat(){ # outfile seg1 seg2 ...
  local out="$1"; shift; : > "$T/seg/list.txt"
  for s in "$@"; do echo "file '$(basename "$s")'" >> "$T/seg/list.txt"; done
  ffmpeg -y -loglevel error -f concat -safe 0 -i "$T/seg/list.txt" -c copy "$out"; }

echo "== overlays =="
lt "$OV/f1_m1.png" "Sofia"  "Spanish · Mango robe satinée 69,99 €"
lt "$OV/f1_m2.png" "Mei"    "East Asian · same dress, no re-shoot"
lt "$OV/f1_m3.png" "Amara"  "Black · same dress, no re-shoot"
lt "$OV/f1_m4.png" "Elin"   "Northern European · same dress, no re-shoot"
lt "$OV/f1_m5.png" "Priya"  "South Asian · same dress, no re-shoot"
lt "$OV/f2_s4.png" "Robe satinée"        "Mango · 69,99 €"
lt "$OV/f2_s2.png" "Combinaison florale" "Mango · 49,99 €"
lt "$OV/f2_s6.png" "Robe à fleurs"       "Mango · 79,99 €"
lt "$OV/f2_c7.png" "Chemise + pantalon lin" "Mango · 89,98 €"
lt "$OV/g_studio.png" "Studio" "Verified try-on"
lt "$OV/g_paris.png"  "Paris, golden hour" "Same face, same garment · AI environment"
lt "$OV/g_terrace.png" "Dusk terrace"      "Same face, same garment · AI environment"
lt "$OV/g_boutique.png" "Boutique"         "Same face, same garment · AI environment"
lt "$OV/g_cafe.png"    "Café terrace"      "Same face, same garment · AI environment"
lt "$OV/g_gallery.png" "Gallery"           "Same face, same garment · AI environment"
card "$T/c_face.png"  "ONE GARMENT" "Every" "face." "The same Mango look on a diverse cast. No re-shoot."
card "$T/e_face.png"  "FROM ONE PACKSHOT" "5 castings." "" "~3 credits per face. Minutes, not weeks."
card "$T/c_look.png"  "ONE FACE" "Every" "look." "Book a model once. She wears the whole rail."
card "$T/c_grey.png"  "OFF THE GREY" "Studio to" "story." "The same verified image, moved into the world."
card "$T/e_grey.png"  "AI CAPABILITY DEMO" "Same identity." "Same garment." "AI environment + AI face. Not a shipped campaign."

echo "== FILM 1: one garment, every face =="
cardseg "$T/c_face.png" 2.6 "$T/seg/a0.mp4"
clipseg "$V/turn_M1_red_satin.mp4" "$OV/f1_m1.png" 2.6 "$T/seg/a1.mp4"
clipseg "$V/face_S4_M2.mp4" "$OV/f1_m2.png" 2.6 "$T/seg/a2.mp4"
clipseg "$V/face_S4_M3.mp4" "$OV/f1_m3.png" 2.6 "$T/seg/a3.mp4"
clipseg "$V/face_S4_M4.mp4" "$OV/f1_m4.png" 2.6 "$T/seg/a4.mp4"
clipseg "$V/face_S4_M5.mp4" "$OV/f1_m5.png" 2.6 "$T/seg/a5.mp4"
cardseg "$T/e_face.png" 2.4 "$T/seg/a6.mp4"
concat "$T/f1_silent.mp4" "$T/seg/a0.mp4" "$T/seg/a1.mp4" "$T/seg/a2.mp4" "$T/seg/a3.mp4" "$T/seg/a4.mp4" "$T/seg/a5.mp4" "$T/seg/a6.mp4"
mux "$T/f1_silent.mp4" "$V/one_garment_every_face.mp4"

echo "== FILM 2: one face, every look =="
cardseg "$T/c_look.png" 2.6 "$T/seg/b0.mp4"
clipseg "$V/turn_M1_red_satin.mp4" "$OV/f2_s4.png" 2.6 "$T/seg/b1.mp4"
clipseg "$V/look_M1_S2.mp4" "$OV/f2_s2.png" 2.6 "$T/seg/b2.mp4"
clipseg "$V/look_M1_S6.mp4" "$OV/f2_s6.png" 2.6 "$T/seg/b3.mp4"
clipseg "$V/look_M1_C7.mp4" "$OV/f2_c7.png" 2.6 "$T/seg/b4.mp4"
cardseg "$T/e_face.png" 2.4 "$T/seg/b5.mp4"
concat "$T/f2_silent.mp4" "$T/seg/b0.mp4" "$T/seg/b1.mp4" "$T/seg/b2.mp4" "$T/seg/b3.mp4" "$T/seg/b4.mp4" "$T/seg/b5.mp4"
mux "$T/f2_silent.mp4" "$V/one_face_every_look.mp4"

echo "== FILM 3: off the grey =="
cardseg "$T/c_grey.png" 2.6 "$T/seg/d0.mp4"
stillseg "$L/S4__M3.jpg" "$OV/g_studio.png" 0.9 "$T/seg/d1.mp4"; stillseg "$C/S4_M3_paris.jpg" "$OV/g_paris.png" 2.2 "$T/seg/d2.mp4"
stillseg "$L/S2__M3.jpg" "$OV/g_studio.png" 0.9 "$T/seg/d3.mp4"; stillseg "$C/S2_M3_boutique.jpg" "$OV/g_boutique.png" 2.2 "$T/seg/d4.mp4"
stillseg "$L/C7__M4.jpg" "$OV/g_studio.png" 0.9 "$T/seg/d5.mp4"; stillseg "$C/C7_M4_cafe.jpg" "$OV/g_cafe.png" 2.2 "$T/seg/d6.mp4"
stillseg "$L/S6__M5.jpg" "$OV/g_studio.png" 0.9 "$T/seg/d7.mp4"; stillseg "$C/S6_M5_gallery.jpg" "$OV/g_gallery.png" 2.2 "$T/seg/d8.mp4"
clipseg "$V/life_terrace.mp4" "$OV/g_terrace.png" 5.0 "$T/seg/d9.mp4"
cardseg "$T/e_grey.png" 2.6 "$T/seg/d10.mp4"
concat "$T/f3_silent.mp4" "$T/seg/d0.mp4" "$T/seg/d1.mp4" "$T/seg/d2.mp4" "$T/seg/d3.mp4" "$T/seg/d4.mp4" "$T/seg/d5.mp4" "$T/seg/d6.mp4" "$T/seg/d7.mp4" "$T/seg/d8.mp4" "$T/seg/d9.mp4" "$T/seg/d10.mp4"
mux "$T/f3_silent.mp4" "$V/off_the_grey.mp4"

echo "== DONE =="; for f in one_garment_every_face one_face_every_look off_the_grey; do
  echo "$f: $(ffprobe -v error -show_entries format=duration -of default=nk=1:nw=1 $V/$f.mp4)s $(ls -la $V/$f.mp4|awk '{print $5}')b"; done
rm -rf "$T/seg"