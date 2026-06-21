# Changelog

## v6 — 2026-06-21 — Scenario brand restyle, garment-left explorer, references, deep links

The **web microsite is the primary deliverable.** This pass restyles it to the Scenario brand and adds what an enterprise buyer looks for. The PDF deck (`deck.html`) was kept at parity in the same commit but is secondary.

### Brand / visual design (matches scenario.com and the Scenario design system, "warm / editorial / light")
- **Instrument Serif** display headings (weight 400), **Instrument Sans** body, **JetBrains Mono** section labels, loaded from Google Fonts.
- Warm paper background (`#FAF8F5`), near-black ink, **terracotta accent (`#C0492B`)** for the primary CTA, links and highlights; warm-gray borders; sharper, editorial corners.
- Section kickers are mono, uppercase, numbered 01 to 11 with a terracotta numeral.

### Explorer: garment in, faces out
- The "one garment, every face" view now shows the **actual source packshot on the left of each row**, then the five model examples, all the same tile size and height (one six-column grid).
- Clicking any face opens a **before to after** in the lightbox: the source packshot (left) beside the generated on-model image (right), equal height, no white box, with the "View on laredoute.fr" link.

### Numbers: a real comparison
- Rebuilt into a **studio vs Scenario** comparison: a large "~$46 to ~$96 per finished image vs ~$0.15" header, a line-by-line table (photographer, model, studio, hair and make-up, retouching, time to first asset), and a **"read this as directional, not exact" caution disclaimer**. Benchmarks re-verified (squareshot, blendnow, nightjar).

### Enterprise references
- Added a **black-and-white reference logo wall** (Lacoste, Ogilvy, Alan, Within) under "Built for teams that can't compromise." NOTE: the asset used is `within.co` (the NYC creative agency); confirm this is the intended "Within" before sending (within.com does not resolve).

### Deep links
- The pilot section now links to **scenario.com, the models, the providers, connect over MCP (`docs.scenario.com/get-started/mcp/mcp`), app.scenario.com and enterprise** (all verified 200). The four prop cards link to the relevant pages.

### Deck (kept at parity, secondary)
- Same brand restyle, the reference logo wall and the deep links on the pilot page, the "directional, not exact" numbers disclaimer, and the remaining Scenario "credits" converted to dollars. 15 pages.

### Fixes (from review feedback)
- Explorer ref tile and lightbox source image **heights harmonized**; removed the white padding/border box around the packshot.

### Performance
- **Compressed all video** for faster load and reliable deploy (ROADMAP item: compress video). Hero `sizzle_9x16.mp4` 1080x1920 at ~5 Mbps (19 MB) to 720x1280 CRF 24 (~5 MB); `sizzle_16x9.mp4` to ~2.4 MB; the 15 loop clips re-encoded to 720x1280 CRF 25 with audio dropped (they autoplay muted), roughly 0.7 to 1.4 MB each. Total media dropped from ~91 MB to ~38 MB. Visually unchanged at the display sizes used on the page.

## v5 — 2026-06-21 — Mango edition

This deliverable was re-aimed at **Mango** (the brand whose garments these are), not La Redoute. The garments were captured from laredoute.fr, but the proposal and site are addressed to Mango. A separate, larger **La Redoute edition** (La Redoute Collections + La Redoute Intérieurs + AM.PM) is planned later; see `ROADMAP.md`.

### Re-targeting
- Recipient is now **Mango** everywhere (nav, title, footer, deck cover/footer, "prepared for"). `laredoute.fr` stays as the capture source. Live URL becomes `scenario-mango-production.up.railway.app`.
- **Removed the "Every brand" section** (site and deck): it showed La Redoute Collections + Vero Moda, which are not Mango. That marketplace story belongs to the La Redoute edition. For Mango, every garment shown is the customer's own product, which makes the rights story stronger (clean by construction).
- **Dropped the "Pruna" / "P-Image" name** from all customer-facing copy (the try-on engine is referred to as "Scenario Try-On" or generically as "try-on"). It is the secret sauce.

### Hero
- Hero now plays the **30s sizzle reel** (was a single 6s loop), sized to a definite 9:16 box (`80vh`) so the whole film is always visible and never taller than the screen (fixed a collapse-to-zero-height bug).
- The reel **opens on a model in the garment** (Amara in the jumpsuit) with the title overlaid, not a black card. `poster` placeholder shows during load.
- Added a real **sound toggle button** on the hero; sound also turns on after the first page interaction (browsers block unmuted autoplay). Lightbox videos open unmuted.
- Refined the hero copy to be clearer and Mango-facing.

### The reel (video only)
- Rebuilt as **video only, no stills** (`reel/build_hero_reel.sh`): title-over-model → "One garment, every face" (jumpsuit on 5 faces) → "One face, every look" (one model in jumpsuit / cut-out / linen) → Paris lifestyle → "Infinite on-model content" CTA. Scenario logo on the cards.
- Earlier interim versions used blurred-fill then cover-crop stills; both removed in favour of all-motion.
- Music is the interim bed track; a custom **ElevenLabs** score is pending an API key (see ROADMAP).

### Copy
- **Dollars, not credits**, in customer-facing numbers (1 credit ≈ $0.05): ~$0.15 per try-on, ~$16 for the 50-image set, ~$79 whole build. Stat bar reframed to "infinite" output (∞ castings / markets, "5 / 6 shown" as examples) from one packshot.
- Provenance trimmed to a **single live screenshot** with a prominent "See the real product page on laredoute.fr" link.
- "Book a model once" reframed to **"Don't book a model. Generate one."** (the model is an AI identity).
- Removed internal sales-speak ("The gates that decide the deal", "first/second gate", "Why us", "signable pilot", "earns the pilot") in favour of customer-facing section titles.

### Enterprise / scale
- Reworked the rights section into **"Built for teams that can't compromise"** and added a security / scale / support block mirroring scenario.com/enterprise: SOC 2 Type II (audited), AES-256, SSO/SAML, activity logging, API rate limits + batch, volume pricing, custom integrations over MCP, named account manager + Slack. Uptime is the **contractual 99.0%** (not the marketing 99.9%).

### Legal accuracy (grounded in the DPA/MSA v2.2)
- **Removed the "EU data residency" claim** (false): data is hosted in the US on AWS (us-east-1, us-west-2); region-specific residency is not offered today (Order Form). Compliance via EU SCCs + UK Addendum + an appointed EU representative; CCPA via service-provider terms (not "via SCCs").
- **Corrected the indemnity claim**: Scenario indemnifies authorized platform use against third-party IP claims; it does **not** indemnify the content of generated output (MSA 9.5). The human-QA gate + rights-clean inputs are the control.
- Enterprise-Ready models reframed from "enabled by default" to an **Order Form option** (otherwise MSA 5.5 governs).
- Kept the real, contractual strengths: no-training guarantee, you own all Generated Assets (MSA 5.3), SOC 2 Type II, 30-day sub-processor notice. An adversarial 6-agent verification pass checked 60 governance/legal claims against the contracts.

## v4 — 2026-06-21
- Jumpsuit re-anchor, universal lightbox, La Redoute Collections + Vero Moda brands, 3-screenshot provenance, measured pilot, accuracy/C10 section removed, two-keyframe motion, GPT Image 2 for full-body geo placement. PDF deck refreshed to parity (then superseded by the Mango reframe above).

## v3 and earlier
- Provenance, geo/localize, channels, automation, two-keyframe motion loops; the 50-look explorer, editorial "ceiling", studio benchmark, rights/pilot. See git history.
