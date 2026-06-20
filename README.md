# Scenario for La Redoute: virtual try-on pitch

An enterprise pitch package from Scenario (Emmanuel de Maistre, Cofounder and CEO) to **La Redoute**, demonstrating Pruna P-Image Try-On built on La Redoute's own live Mango catalog. It ships as a static microsite plus a print-ready PDF, and deploys to Railway.

> **Confidential.** Prepared for La Redoute. Garments belong to Mango, sourced via laredoute.fr as a one-time evaluation artifact. Faces are AI-generated. Repo is private.

## What is in here
- **`index.html`** : interactive microsite. Hero plays a 30-second branded film; a 50-look explorer with a one-garment/every-face and one-face/every-look toggle and a click-to-zoom QA lightbox; a before/after "ceiling" section (studio to editorial); accuracy, rights, numbers and a pilot CTA.
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

## The spine (do not break)
Credibility is the product. The deck opens on a verified, bounded claim, states the boundary out loud, owns the one fidelity miss (C10) against the pixels under a named QA gate, and concedes C9 as a colorway win. See `CLAUDE.md` for the hard guardrails.

## Cost
~1,300 Scenario credits across the whole build (50 stills ~325, motion clips ~876, editorial renders ~80, music ~15, re-poses ~26). A few dollars to low tens. Built on the Public Data project.
