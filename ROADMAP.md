# ROADMAP

## v7 pending (needs new Scenario generation, GATE 1 cost approval)
- **Fix the C7/C8/C9 combo bottoms.** The multi-piece looks render the bottom garment off: C7 "linen wide-leg" rendered near-black, C9 wide-leg rendered straight (not wide), C8 skirt is faint. Re-generate those try-ons (correct colours, wide-leg cut, skirt visible). Estimate: a few dollars of credits per look x models.
- **Replace the satin dress (S4).** Remove "Robe satinee asymetrique" and scrape + generate a better Mango garment from laredoute.fr (master is reused; ~$0.15 x 5 try-ons + a packshot). Then drop S4 from LOOKS and add the new look.
- **Confirm "Within" reference** (within.co vs within.com) and Epic Games / Deel / Alan are intended Scenario references before sending.

## v6 done (2026-06-21)
- Scenario brand restyle (warm/editorial/light, from scenario.com + the design system), garment-left explorer with a before/after lightbox, studio-vs-Scenario numbers with a "directional, not exact" disclaimer, a B&W reference logo wall, and deep links to scenario.com / models / providers / MCP / app / enterprise. The web microsite is the primary deliverable; the deck is kept at parity.
- **Confirm the "Within" reference.** The logo wall uses `within.co` (NYC creative agency) because `within.com` does not resolve. Verify with Emmanuel which "Within" is the intended Scenario reference and swap `media/logos/within.svg` if needed.

## v5 (Mango edition) follow-ups
- **The La Redoute edition (bigger).** A separate site/deck for La Redoute as a marketplace: La Redoute Collections (own label, `brndid=la-redoute-collections`), La Redoute Intérieurs (`brndid=la-redoute-interieurs`) and AM.PM. Reuses this codebase; restores the "every brand" story and the `media/brands/*` assets. Likely its own Railway service `scenario-laredoute` and possibly its own repo.
- **Reel Act 3: "one face, one look, every environment."** Generate the same model (clean base image) in varied backgrounds, actions, angles and positions via GPT Image 2 img2img, then animate each with Seedance so the reel stays video-only. NEEDS a GATE 1 cost approval (Scenario credits, est. a few tens of $ for ~8 environment clips).
- **Custom ElevenLabs music** for the reel, matched to the cuts. BLOCKED: no ElevenLabs API key found locally; needs a key from Emmanuel (or fall back to Scenario Sonilo).
- **Favicon + OpenGraph/Twitter cards** (silences the console 404; nice link previews). One small change, batch with the next deploy.
- **Password-protect the site** before wide external sharing (confidential).



Ordered by leverage. (v4 note: item 1, own-brand, is DONE. Item 0, the PDF deck refresh, is DONE: site and deck are now at parity. The top open item is now body-size range, item 2.)

## v4 follow-up
0. ~~**Refresh the PDF deck to v4 parity.**~~ **DONE (v4).** `deck.html` / `Scenario-La-Redoute-Proposal.pdf` rebuilt to match `index.html`: jumpsuit lead, Every-brand page, 3-screenshot provenance, off-the-grey + Localize geo, two-keyframe motion, measured pilot, accuracy/C10 page removed. Now 16 pages (appendix split so the cited sources stay on-page). Send the deck and the site together.

## v4 loose end (needs a quick call)
0b. **Sizzle reel is pre-v4 (red-satin-led).** `reel/build_reel.sh` and `media/video/sizzle_*.mp4` predate the jumpsuit re-anchor and are currently orphaned (not linked by site or deck), but `README.md` lists them in the package. Either rebuild the reel jumpsuit-led (ffmpeg, no credits) or drop it from the package so the leave-behind is internally consistent. See `BUGS.md`.

## Highest leverage (turn promises into proof)
1. ~~**Own-brand render.**~~ **DONE (v4).** A real La Redoute Collections garment (Robe en lin Signature HELOISE, scraped from laredoute.fr) is rendered on the house cast in `#brands`, beside a Vero Moda tenant-brand garment. The rights gate is now proof, not a promise.
2. **Body-size range.** Dress one look across XS to XXL house builds (the dimension that actually drives fashion returns). Converts "every face" honesty into evidence and previews the returns lever.

## Strong follow-ups
3. **More angles per look:** back view and 3/4 view (not just one frontal hero), so a PDP carousel is complete.
4. **Alternate poses per model at scale** via re-pose (the pose strip shows the capability; productionize it).
5. **Localized variants** per market, and seasonal restyling of the same model library.
6. **Cross-model "one garment, every face" motion** (held back for now: face-morphing has a representation-critique risk; only ship behind a garment-shape and face-stability QA pass).

## Platform / enterprise
7. **PIM/DAM integration via API/MCP:** packshot in, SKU-keyed on-model asset and clip out, with the human-QA gate before publish.
8. **Acceptance rubric tooling:** lighting, styling, drape, print-scale, color-accuracy, silhouette; a publishable-unedited pass-rate dashboard.
9. **Real-talent option:** render on contracted talent instead of synthetic faces where the brand prefers it.
10. **Measurement:** a controlled PDP A/B (conversion + fit-related returns) with pre-agreed sample size and thresholds (Phase 2).

## Site / repo polish
11. **Custom domain + password protection** for the microsite (it is a confidential pitch); add HTTP basic auth or a simple gate before sharing the live URL externally.
12. **Add a favicon and OpenGraph/Twitter cards** (the link should preview nicely when shared).
13. **Compress video** further (HLS or smaller bitrate) if load time matters on slower connections.
14. **CI:** a tiny GitHub Action to lint HTML and re-render the PDF on push.

## Commercial
15. **The pilot (now framed as measured, v4):** the site no longer commits to SKU counts, phases, timelines or commercials. It states the work runs today, can be proven on the client catalog in days, and that Scenario has everything, then offers the 30-minute working session. Keep it that way unless the client asks for a scoped proposal; if they do, the internal options (sample slice, success metric, A/B, pricing) live here, not on the public page.
