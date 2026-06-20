# DOCS: how the pitch was produced

End-to-end documentation of the pipeline, assets, and reproduction steps.

## 1. The pipeline
```
La Redoute PDP packshot  ->  GPT Image 2 (house model)  ->  Pruna P-Image Try-On (dress)
                                                              |
                              Gemini 3.1 Flash (editorial environment, "ceiling")
                                                              |
                              Seedance 2.0 Fast (motion)  ->  ffmpeg (sizzle reel + music)
```
Identity, pose, shoes and backdrop are preserved at the try-on step. Only clothing changes. Combos (2 to 3 pieces) dress in one Pruna pass (up to 11 garment references).

## 2. Scraping La Redoute (free)
- laredoute.fr blocks plain HTTP (Cloudflare 403). A real browser (Playwright) clears the challenge; the cookie persists.
- Each product page embeds a `schema.org/Product` JSON-LD block with the ordered `image[]` array. That is the authoritative, noise-free list of the product's own photos.
- The clean no-mannequin still-life packshot is identified among them and downloaded by navigating the tab to the image (same-origin) and exporting a `<canvas>.toDataURL` (the CDN is CORS-locked to `fetch`).
- 99 Mango products were read; 10 looks selected (6 singles + 4 combos = 15 garment images).

## 3. The cast (5 house models)
| Code | Casting | Pose |
|---|---|---|
| M1 Sofia | Spanish, 27 | contrapposto, hand on hip |
| M2 Mei | East Asian, 24 | walking stride |
| M3 Amara | Black, 30 | front-facing |
| M4 Elin | Northern European, 22 | relaxed lean |
| M5 Priya | South Asian, 35 | straight-on power stance |

All share one slim build (see guardrail 1). Two clearly distinct poses in the cast plus frontal variation; per-model pose variety is shown via re-pose (`media/pose_strip.jpg`), scoped as a pilot deliverable.

## 4. The 10 looks
S1 Robe chemisier floral 39,99 / S2 Combinaison florale 49,99 / S3 Robe asymetrique fleurie 79,99 / S4 Robe satinee 69,99 / S5 Robe bustier en jean 49,99 / S6 Robe a fleurs cut-out 79,99 / C7 Chemise + pantalon lin / C8 Top + jupe lin / C9 Blouse + pantalon wide-leg (burgundy) / C10 Chemise rayee + pantalon + blazer lin. The 50 try-ons are `media/looks/<CODE>__<M>.jpg`.

## 5. The "ceiling" (editorial environments)
Six verified try-ons were placed into editorial environments with Gemini 3.1 Flash img2img, hard-locking identity and garment and changing only environment and light. Outputs in `media/ceiling/`. Shown as before/after pairs in the site `#ceiling` section and deck page 4. Hard-labelled AI capability demonstration.

## 6. Motion and the sizzle reel
- 5 per-model clips + 1 editorial-environment clip (dusk terrace), Seedance 2.0 Fast, 5s, 720p, 9:16, first-frame mode from the approved still.
- `reel/build_reel.sh` assembles the 30-second film: Act 1 (studio clips + lower-thirds + AI tag), Act 2 (the lifestyle clip + editorial Ken-Burns beats + capability label), Act 3 (CTA card), scored to `media/audio/bed.mp3`. Text is pre-rendered PNG (ffmpeg here lacks drawtext); composited via `overlay`, segments concatenated, music muxed with `loudnorm` + `afade`. Outputs `media/video/sizzle_9x16.mp4` and `sizzle_16x9.mp4`.

## 7. The documents
- `deck.html` -> Chrome headless `--print-to-pdf` -> `Scenario-La-Redoute-Proposal.pdf` (15 pages, A4). Swiss-minimal, serif display headings, per-page confidential footer.
- `index.html`: self-contained microsite, vanilla HTML/CSS/JS, lazy-loaded explorer, lightbox, autoplay-muted hero reel.

## 8. Cost benchmark (cited)
Studio: ~$46 per finished image lean (one-day, ~60 images, ~$2,750), ~$96 fully-loaded on line items, effective 2 to 3x once coordination and re-shoots are counted. Sources: squareshot.com, blendnow.com, nightjar.so. Scenario: ~3 credits per try-on, ~325 for the 50-image set, plus QA labor as the cost that scales.

## 9. Reproduction
1. `npm install && npm start` to view the site.
2. Regenerate any asset via the Scenario MCP models in section 1 (project `bftve3VtQgmpXxwAPUFWTQ`).
3. Rebuild the PDF and reel with the commands in `README.md`.
