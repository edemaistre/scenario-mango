# CLAUDE.md : working in this repo

This repo is a confidential B2B pitch from Scenario. The product of the pitch is **credibility**. If you edit anything, protect the honesty spine below. It is what makes it land with an enterprise buyer.

## Who it is for (read first)
- **This is the MANGO edition.** The recipient is **Mango**, the brand whose garments these are. Everything shown is a real Mango product, captured from **laredoute.fr** (the capture source, which you may name) and addressed to Mango. Live URL: `scenario-mango-production.up.railway.app`.
- A separate, larger **La Redoute edition** is planned (La Redoute Collections + La Redoute Intérieurs + AM.PM). That is where the "marketplace / many brands / own-label" story lives. Do NOT put La Redoute Collections or Vero Moda content in the Mango edition.

## Hard guardrails (never break)
1. **Say "every face", never "every body".** All five models share one slim build. Body-size and fit inclusivity is a pilot deliverable, not a proven result. Faces/castings can be framed as effectively infinite; body range cannot.
2. **The editorial / geo images are a labelled AI capability demonstration.** AI environment + AI face, same identity and garment preserved from the verified studio still. Never present them as a shipped campaign.
3. **Everything shown is Mango's own product.** That is the rights story: clean by construction. Do NOT reintroduce the "Every brand" section (La Redoute Collections + Vero Moda) into the Mango edition; it was removed on purpose. The brand montages (`media/brands_grid.jpg`, `media/brands/*`) stay in the repo for the future La Redoute edition, unsurfaced here.
4. **The Mango packshots are a one-time evaluation artifact, quarantined from production claims.** Production runs only on assets the client warrants it has rights to.
5. **Never name the try-on model.** Do NOT mention "Pruna" or "P-Image" in any customer-facing copy (site, deck, reel). It is the secret sauce. Call it "Scenario Try-On" or just "try-on". (GPT Image 2 / Seedance are not the secret sauce, but the deck genericises the pipeline to "master / try-on / motion" anyway.)
6. **Dollars, not credits, in customer-facing copy.** 1 credit ~= $0.05. Use ~$0.15 per try-on, ~$16 for the 50-image set, ~$79 whole build. Keep the cited studio benchmark (squareshot, blendnow, nightjar) and the "2 to 3x" overrun figure.
7. **No em dashes in any copy.** Colon, comma, or rewrite.
8. **No internal sales-speak in customer-facing copy.** This is prospect-facing. Banned: "the gates that decide the deal", "first/second gate", "Why us", "signable pilot", "earns the pilot", "the moat". Use plain section titles (Rights and IP, Security and scale, What makes this different).
9. **Two files, two jobs:** `deck.html` renders the PDF; `index.html` is the site. Keep claims identical across both; change both in the same commit.
10. **Hero example = the floral jumpsuit (S2, SKU 602618087).** Do not re-anchor featured spots to the red satin dress (S4); it stays only in the 50-grid explorer.
11. **Legal claims are grounded in the DPA/MSA v2.2** (extracted text was at `/tmp/scenario_contracts/`). The true posture: US (AWS us-east-1, us-west-2) hosting, **NO EU data residency** (Order Form only); GDPR/UK/Swiss compliance via **EU SCCs + UK Addendum + appointed EU representative (DataRep, Ireland)**; **CCPA via service-provider terms, NOT "via SCCs"**; a contractual **no-training guarantee**; client **owns all Generated Assets (MSA 5.3)**; SOC 2 Type II (under NDA), AES-256 at rest, SSO/SAML, 30-day sub-processor notice; **99.0% uptime SLA** (the contract figure, NOT the marketing 99.9%). Indemnity covers **authorized platform use** against third-party IP, NOT the content of generated output (MSA 9.5); the human-QA gate + rights-clean inputs are the control. Enterprise-Ready models are an **Order Form option**, not a standing default.

## Brand / visual design (v6, do not regress)
- The site and deck follow the **Scenario brand** ("warm / editorial / light"), read directly off scenario.com and the Scenario design system (`scenariods-xqdhrhyx.manus.space`). Tokens: paper `#FAF8F5`, ink `#15151a`, warm-gray line `#e7e2d9`, panel `#f2eee6`, **terracotta accent `#C0492B`** (CTA, links, highlights), hover `#a23b20`.
- Type: **Instrument Serif** for h1/h2 at weight 400 (the face ships only 400 + italic, so never rely on bold serif: use Instrument Sans semibold for emphasis); **Instrument Sans** body; **JetBrains Mono** for kickers, the "vs" labels, and ref/lightbox captions. Loaded from Google Fonts; keep the `<link>` tags in both files.
- Kickers are mono, uppercase, numbered (`<span class="n">01</span> ...`, terracotta numeral).
- Explorer "by look" is one **six-column grid** per look (packshot + 5 models, equal tile height); the packshot fills its tile (`object-fit:cover`, no white box). Clicking a face opens a **before to after** in the lightbox: packshot left, generated right, both fixed `height:72vh` so heights match (no white box; the white on a packshot is its own product background).

## References + deep links (v6)
- Reference logo wall (B&W via `filter:brightness(0)`, transparent source logos in `media/logos/`): Lacoste, Ogilvy, Alan, Within. The "Within" asset is **within.co** (NYC creative agency); within.com 500s. CONFIRM with Emmanuel that within.co is the intended brand before sending; swap `media/logos/within.svg` if not.
- Verified Scenario links (all 200): home `scenario.com`, models `scenario.com/models`, providers `scenario.com/providers`, MCP docs `docs.scenario.com/get-started/mcp/mcp`, app `app.scenario.com`, enterprise `scenario.com/enterprise`. Do NOT cite `scenario.com/integrations` (404).

## Hero reel
- Hero plays `media/video/sizzle_9x16.mp4` (the 30s reel), in a definite 9:16 box sized to `80vh` so the whole film is visible and never taller than the viewport (do NOT use `width:auto`/`aspect-ratio` alone on the reelwrap, it collapses to 0 height). `poster="media/hero_s2.jpg"` is the load placeholder.
- The reel **opens on a model in the garment** with the title overlaid (frame 1 must not be a black card). A visible **sound toggle button** controls audio; sound also turns on after the first page gesture (browser autoplay policy).

## The reel (`reel/build_hero_reel.sh`)
- **Video only, no stills.** Acts: title-over-model -> "one garment, every face" (loop_S2_M1..M5) -> "one face, every look" (loop_M1_S2/S6/C7) -> Paris lifestyle (loop_S2_life) -> "Infinite on-model content" CTA. Scenario logo (white) on the cards.
- All clips are 720x1280 (clean 9:16); `clipseg` scales with `force_original_aspect_ratio=increase,crop` (no squish). The old `build_reel.sh`/`build_films.sh` reference deleted `turn_/face_/look_/life_` clips and are red-satin-led; do not use them.
- This ffmpeg has **no drawtext** (all text is pre-rendered PNG overlays). Music is the interim `media/audio/bed.mp3`; a custom ElevenLabs score is pending an API key.

## Motion clips (the looping galleries)
- Two-keyframe: Seedance 2.0 Fast with `image` (verified try-on still) + `lastFrameImage` (a Gemini re-pose of the SAME garment mid-walk), 6s, 720p, 9:16, `generateAudio:false`. Never single-first-frame (drifts) or first=last (static).

## Full-body placement
- Use **GPT Image 2 img2img**, NOT Gemini, for placing a person into an environment (Gemini stretches body proportions). Gemini is fine for same-framing studio re-pose. The try-on accepts a dressed still as `personImage` with `preserveInputSize:true` to keep proportions.

## Models / project (do not name Pruna in copy)
- Master: GPT Image 2 (`model_openai-gpt-image-2`, medium, 1024x1536). Try-on: the Scenario try-on model (~3 CU, up to 11 refs, `preserveInputSize:true`). Re-pose/editorial: Gemini 3.1 Flash. Motion: Seedance 2.0 Fast. Project: Public Data Default (team/project `bftve3VtQgmpXxwAPUFWTQ`).

## Rebuild commands
- PDF: `"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless --disable-gpu --no-pdf-header-footer --virtual-time-budget=20000 --print-to-pdf="Scenario-La-Redoute-Proposal.pdf" "file://$PWD/deck.html"`. 15 pages (Mango edition). `.page` is `overflow:hidden`, so overflow is silently CLIPPED, not paginated: cap tall images and split dense pages, QC every page after a content change.
- Reel: `bash reel/build_hero_reel.sh` (ImageMagick + ffmpeg).

## Deploy
Static Express server (`server.js`) on Railway. Mango edition deploys to the `scenario-mango` service -> `scenario-mango-production.up.railway.app`. One deploy per change set; batch edits. NOTE: same-named asset files (e.g. `media/geo/*.jpg`) changed between versions are browser-cached; hard-refresh or cache-bust when content changes under an unchanged filename.

## Doc hygiene (Emmanuel's standard)
Any behavior change updates, in the same commit: `README.md`, `DOCS.md`, `BUGS.md`, `ROADMAP.md`, `CHANGELOG.md`, and this file.
