# Changelog

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
