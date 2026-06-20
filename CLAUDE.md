# CLAUDE.md : working in this repo

This repo is a confidential B2B pitch from Scenario to La Redoute. The product of the pitch is **credibility**. If you edit anything, protect the honesty spine below. It is what makes the deck land with an enterprise buyer.

## Hard guardrails (never break)
1. **Say "every face", never "every body".** All five models share one slim build. Body-size and fit inclusivity is a **Phase-1 pilot deliverable**, not a proven result. Do not imply otherwise.
2. **The editorial "ceiling" images are a labelled AI capability demonstration.** AI environment + AI face, same identity and garment preserved from the verified studio still. Never present them as a shipped La Redoute campaign or as own-brand proof.
3. **No own-brand render exists.** It is named as a Phase-1 deliverable everywhere. Do not fabricate one or claim it as done.
4. **The Mango packshots are a one-time evaluation artifact, quarantined from production claims.** Production runs only on assets La Redoute warrants it has rights to.
5. **Every fidelity claim is verified against the source packshot at zoom.** Do not assert a fidelity hold or miss you have not checked against pixels. C10 = silhouette substitution (cropped short-sleeve shirt rendered long-sleeve full-length, stripe faded). C9 = colorway win (burgundy reproduced from a mislabeled "Jean large"), not a miss.
6. **No em dashes in any copy.** Use a colon, comma, or rewrite. Cost benchmarks must stay cited (squareshot, blendnow, nightjar) and the effective-overrun figure is "2 to 3x", the sourced number.
7. **Two text files, two jobs:** `deck.html` renders the PDF; `index.html` is the site. Keep claims identical across both.

## How it was built (tools)
- Scrape: Playwright clears Cloudflare on laredoute.fr; product JSON-LD gives the authoritative image array; packshots downloaded via canvas export (CDN is CORS-locked to fetch).
- Master model: GPT Image 2 (`model_openai-gpt-image-2`, quality medium, 1024x1536, ~12 CU).
- Try-on: Pruna P-Image Try-On (`model_pruna-p-image-try-on`, ~3 CU, up to 11 garment refs, combos in one pass, `preserveInputSize:true`).
- Re-pose / editorial environments: Gemini 3.1 Flash img2img (`model_google-gemini-3-1-flash`, ~13 CU at 1K).
- Motion: Seedance 2.0 Fast (`model_bytedance-seedance-2-0-fast`, 146 CU at 5s/720p, first-frame mode from the approved still).
- Music: Sonilo (`model_sonilo-v1-1-text-to-music`).
- Scenario project: Public Data Default (team/project `bftve3VtQgmpXxwAPUFWTQ`).

## Rebuild commands
- PDF: see README. Re-render after any `deck.html` change. Keep it to 15 pages; QC pages for footer overlap.
- Reel: `bash reel/build_reel.sh`. This ffmpeg build has **no drawtext filter**: all text is pre-rendered PNG overlays composited with `overlay` / concat. Do not add `drawtext`.

## Deploy
Static Express server (`server.js`) on Railway. `railway up` then `railway domain`. One deploy per change set; batch edits.

## Doc hygiene (Emmanuel's standard)
Any change that alters behavior updates, in the same commit: `README.md`, `DOCS.md`, `BUGS.md` (if a bug is found or fixed), `ROADMAP.md` (if priorities shift), and this file (if a new pattern is learned).
