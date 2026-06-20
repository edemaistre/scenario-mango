# Scenario for La Redoute: virtual try-on pitch

An enterprise pitch package from Scenario (Emmanuel de Maistre, Cofounder and CEO) to **La Redoute**, demonstrating Pruna P-Image Try-On built on La Redoute's own live Mango catalog. It ships as a static microsite plus a print-ready PDF, and deploys to Railway.

> **Confidential.** Prepared for La Redoute. Garments belong to Mango, sourced via laredoute.fr as a one-time evaluation artifact. Faces are AI-generated. Repo is private.

## What is in here
- **`index.html`** : interactive microsite (v4), led by the floral jumpsuit. Hero plays a looping motion clip. Sections: Today to Tomorrow (live La Redoute PDP, 3 screenshots, vs enriched), one-garment-every-face and one-face-every-look looping galleries, off-the-grey (studio to editorial), Localize per market (geo), Every brand (La Redoute Collections own-label + Vero Moda try-ons), One asset every channel (Instagram / TikTok / UA mockups), Automate (agents / MCP / Skills), the 50-look explorer, rights, numbers, measured pilot CTA. A universal lightbox makes every image and video click-to-enlarge, with left/right navigation and a link to the live product page.
- **`Scenario-La-Redoute-Proposal.pdf`** : the 15-page leave-behind, rendered from `deck.html`.
- **`deck.html`** : source of the PDF.
- **`media/`** : all assets. `looks/` (50 try-ons), `ceiling/` (6 editorial renders), `packshots/` (15 source packshots), `video/` (5 per-model clips, 1 lifestyle clip, the 9:16 + 16:9 sizzle reels), `audio/` (music bed), plus montages and the hero frame.
- **`reel/`** : the sizzle-reel build script and its text/overlay PNGs.
- **`server.js` / `package.json`** : minimal Express static server for Railway.
- Docs: `DOCS.md` (method), `BUGS.md` (known issues), `ROADMAP.md` (next), `CLAUDE.md` (agent guide), `READ-ME-FIRST.md` (how to send it).

## Run locally
```bash
npm install
npm start          # serves on http://localhost:3000 (or $PORT)
```

## Deploy (Railway)
This repo deploys as a Node static server (Nixpacks detects `package.json`, runs `npm install` then `npm start`).
```bash
railway up         # from the linked project
railway domain     # generate / show the public URL
```
**Live:** https://scenario-la-redoute-production.up.railway.app
**Repo:** https://github.com/edemaistre/scenario-la-redoute (private)

Note: Railway deploys from a local `railway up` (not GitHub auto-deploy). After changing site files, run `railway up` again to publish. The site is currently public on the URL above; see ROADMAP item 11 to password-protect it before wide external sharing.

## Rebuild the artifacts
- **PDF:** `"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless --disable-gpu --no-pdf-header-footer --virtual-time-budget=20000 --print-to-pdf="Scenario-La-Redoute-Proposal.pdf" "file://$PWD/deck.html"`
- **Sizzle reel:** `bash reel/build_reel.sh` (requires ffmpeg + ImageMagick; the per-model clips, editorial renders and `media/audio/bed.mp3` must be present).

## What is new in v4 (2026-06-21)
- **Re-anchored on the floral jumpsuit** (S2, Combinaison imprime floral, SKU 602618087). It is now the hero and the lead example in every section. The red satin dress was pulled from all featured spots (it stays as one of the 50 in the explorer).
- **Every brand, your own included.** New `#brands` section: a La Redoute Collections garment (their own label) and a Vero Moda garment, both scraped live from laredoute.fr and dressed on the house cast. The own-brand render is now real proof, not a deferred Phase-1 promise.
- **Universal lightbox.** Click any image or video anywhere on the page to open it large, step left/right through that gallery, and follow a "View on laredoute.fr" link to the live product.
- **Provenance shows the real page:** the "Today" column carries three live PDP screenshots, not one.
- **Measured pilot.** No timeline/cost/phase commitments: it states the work runs today, can be proven on the client catalog in days, and that Scenario has everything; keeps the "Book the working session" CTA. The dedicated accuracy/C10 section was removed at the client's direction.
- **Engaging motion, no garment drift.** Clips are two-keyframe interpolations: pose A (verified try-on still) to pose B (a re-posed walk of the SAME garment) via Seedance. Real walking motion, garment length locked at both ends.
- **Geo placement uses GPT Image 2.** Gemini stretched body proportions on two full-body environment swaps; those were redone with GPT Image 2 img2img, which holds proportions. See `BUGS.md`.
- **The PDF deck still lags the site.** Refresh `deck.html` before sending the two together (see `ROADMAP.md`).

## The spine (do not break)
Credibility is the product. The deck opens on a verified, bounded claim, states the boundary out loud, owns the one fidelity miss (C10) against the pixels under a named QA gate, and concedes C9 as a colorway win. See `CLAUDE.md` for the hard guardrails.

## Cost
~1,300 Scenario credits across the whole build (50 stills ~325, motion clips ~876, editorial renders ~80, music ~15, re-poses ~26). A few dollars to low tens. Built on the Public Data project.
