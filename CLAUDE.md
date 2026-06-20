# CLAUDE.md : working in this repo

This repo is a confidential B2B pitch from Scenario to La Redoute. The product of the pitch is **credibility**. If you edit anything, protect the honesty spine below. It is what makes the deck land with an enterprise buyer.

## Hard guardrails (never break)
1. **Say "every face", never "every body".** All five models share one slim build. Body-size and fit inclusivity is a **Phase-1 pilot deliverable**, not a proven result. Do not imply otherwise.
2. **The editorial "ceiling" images are a labelled AI capability demonstration.** AI environment + AI face, same identity and garment preserved from the verified studio still. Never present them as a shipped La Redoute campaign or as own-brand proof.
3. **Own-brand render now exists (v4).** A real La Redoute Collections garment scraped from laredoute.fr is rendered on the house cast in `#brands`, beside a Vero Moda tenant-brand garment. This is honest proof: a real garment from their live site, on AI faces, grey studio (same fidelity basis as Mango). Do not downgrade it back to a "Phase-1 promise"; do not fabricate additional own-brand claims beyond what is rendered.
4. **The Mango packshots are a one-time evaluation artifact, quarantined from production claims.** Production runs only on assets La Redoute warrants it has rights to.
5. **Every fidelity claim is verified against the source packshot at zoom.** Do not assert a fidelity hold or miss you have not checked against pixels. C9 = colorway win (burgundy reproduced from a mislabeled "Jean large"), kept. NOTE (v4): the dedicated accuracy/C10 confession section and the explorer C10 "caveat" badge were REMOVED from the site at the client's direction ("everything is supposed to hold; no need to shoot ourselves in the foot"). Do not re-add them to the site. The C10 case still informs the human-QA-gate rationale (kept in Automate/Explorer copy) and still appears in the PDF deck until that is refreshed.
6. **No em dashes in any copy.** Use a colon, comma, or rewrite. Cost benchmarks must stay cited (squareshot, blendnow, nightjar) and the effective-overrun figure is "2 to 3x", the sourced number.
7. **Two text files, two jobs:** `deck.html` renders the PDF; `index.html` is the site. Keep claims identical across both. (v4: the site is ahead; the deck must be refreshed to match, see ROADMAP item 0.)
8. **Hero example = the floral jumpsuit (S2, SKU 602618087), v4.** Do not re-anchor featured spots to the red satin dress (S4); it stays only in the 50-grid explorer.
9. **Motion = two-keyframe.** Seedance 2.0 Fast with `image` (the verified try-on still, pose A) + `lastFrameImage` (a Gemini re-pose of the SAME garment mid-walk, pose B), 6s, 720p, 9:16, `generateAudio:false`. Never single-first-frame (garment drifts) or first=last (static/boring).
10. **Full-body person-into-environment placement: use GPT Image 2 img2img, NOT Gemini.** Gemini 3.1 Flash stretches body proportions on full-body scene swaps (it elongated two geo renders). Gemini is fine for the same-framing studio walk re-pose; for geo/editorial placement prefer GPT Image 2 (`referenceImages` + prompt demanding natural proportions, 1024x1536, quality medium). Pruna try-on accepts a dressed still as `personImage` (it re-dresses) and `preserveInputSize:true` keeps natural proportions.

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
