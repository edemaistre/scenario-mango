# Scenario for Mango: virtual try-on pitch (Mango edition, v6)

An enterprise pitch package from Scenario (Emmanuel de Maistre, Cofounder and CEO) to **Mango**, demonstrating Scenario's on-model try-on built on Mango's own products. The garments were captured from **laredoute.fr** (the capture source); the proposal is addressed to **Mango**. It ships as a static microsite plus a print-ready PDF, and deploys to Railway.

> **Confidential.** Prepared for Mango. Every garment shown is a real Mango product, captured via laredoute.fr as a one-time evaluation artifact. Faces are AI-generated. Repo is private.
>
> **Editions:** this is the **Mango edition**. A separate, larger **La Redoute edition** (La Redoute Collections + La Redoute Intérieurs + AM.PM) is planned, see `ROADMAP.md`. The "every brand / marketplace" story belongs to that edition, not this one. Do not name "Pruna" in customer-facing copy.

## What is in here
- **`index.html`** : interactive microsite (v5), led by the floral jumpsuit. Hero plays the 30s sizzle reel (opens on a model, sound toggle, fits the viewport). Sections: Today to Tomorrow (one live laredoute.fr screenshot + link, fixed-vs-infinite), one-garment-every-face and one-face-every-look looping galleries, off-the-grey (studio to editorial), Localize per market (geo), One asset every channel (Instagram / TikTok / UA mockups), Automate (agents / MCP / Skills), the 50-look explorer, numbers (in dollars), an enterprise "Built for teams that can't compromise" block, measured pilot CTA. A universal lightbox makes every image and video click-to-enlarge, with navigation and a link to the live product page.
- **`Scenario-Mango-Proposal.pdf`** : the 15-page leave-behind, rendered from `deck.html`, at parity with the Mango site. (Filename kept for continuity; content is the Mango edition.)
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
**Live (Mango edition):** https://scenario-mango-production.up.railway.app
**Repo:** https://github.com/edemaistre/scenario-la-redoute (private)

Note: Railway deploys from a local `railway up` (not GitHub auto-deploy). After changing site files, run `railway up` again to publish. The site is currently public on the URL above; see ROADMAP item 11 to password-protect it before wide external sharing.

## Rebuild the artifacts
- **PDF:** `"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless --disable-gpu --no-pdf-header-footer --virtual-time-budget=20000 --print-to-pdf="Scenario-Mango-Proposal.pdf" "file://$PWD/deck.html"`
- **Sizzle reel:** `bash reel/build_hero_reel.sh` (requires ffmpeg + ImageMagick; the `loop_*` clips, the Scenario logo PNGs and `media/audio/bed.mp3` must be present).

## What is new in v6 (2026-06-21)
The **web microsite is the primary deliverable**; the PDF is kept in sync but secondary. Full detail in `CHANGELOG.md`. Headlines:
- **Restyled to the Scenario brand** ("warm / editorial / light", from scenario.com and the Scenario design system): Instrument Serif headings, Instrument Sans body, JetBrains Mono numbered kickers, warm paper, terracotta accent.
- **Explorer shows the source packshot on the left** of each "one garment, every face" row (uniform tile heights), and clicking a face opens a **before to after** (packshot left, generated right) in the lightbox.
- **Numbers reframed as a studio vs Scenario comparison** (~$46 to ~$96 vs ~$0.15) with a line-by-line table and a "directional, not exact" caution disclaimer.
- **Reference logo wall** (B&W: Lacoste, Ogilvy, Alan, Within) under the enterprise block. Note: `within.co` was used; confirm it is the intended "Within".
- **Deep links** to scenario.com, the models, the providers, MCP, app.scenario.com and enterprise (all verified 200).
- Deck kept at parity; remaining "credits" converted to dollars. Fixed explorer/lightbox heights and removed the white packshot box.

## What was new in v5 (Mango edition, 2026-06-21)
Full detail in `CHANGELOG.md`. Headlines:
- **Re-aimed at Mango** (recipient), captured from laredoute.fr (source). New URL `scenario-mango-production.up.railway.app`.
- **Removed the "Every brand" section** (it showed non-Mango brands); for Mango every garment shown is the customer's own product.
- **Pruna name dropped** from all customer-facing copy.
- **Hero plays the 30s reel** (opens on a model, sound toggle button, fits the viewport, poster placeholder). The reel is video-only with two acts (one garment every face, one face every look) plus a lifestyle beat and an "Infinite on-model content" CTA.
- **Dollars, not credits** in customer-facing numbers. Stat bar reframed to infinite output.
- **Enterprise/scale block** mirroring scenario.com/enterprise (SOC 2 Type II, SSO/SAML, API + batch, volume pricing, named support), at the contractual 99.0% uptime.
- **Legal corrected against the DPA/MSA:** no EU residency (US/AWS + SCCs + EU representative), CCPA via service-provider terms, indemnity scoped to platform use not output, Enterprise-Ready is an Order Form option.
- Internal sales-speak removed (no "gates that decide the deal" etc.).

## The spine (do not break)
Credibility is the product. It opens on a verified, bounded claim, states the boundary out loud, verifies every fidelity claim against the pixels under a named human-QA gate, concedes C9 as a colorway win, and every garment shown is the customer's own product. Legal claims are grounded in the DPA/MSA (no overclaiming EU residency, indemnity, or SLAs). See `CLAUDE.md` for the hard guardrails.

## Cost
About **$79** of Scenario compute across the whole build (~$16 for the 50 on-model stills, ~$53 for the 6 motion clips, ~$8 re-poses + geo + lifestyle, ~$2 geo redos + music). A few tens of dollars. Built on the Public Data project. (1 credit ~= $0.05.)
