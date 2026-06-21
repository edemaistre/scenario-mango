# BUGS and known issues

## Fixed in v6 (2026-06-21)
- **Explorer ref tile too tall / white box.** The source packshot tile in the "one garment, every face" view rendered taller than the model tiles and sat inside a white padded/bordered box (`.refbox` had `border`, `padding`, `background:#fff`, `object-fit:contain`). Fixed: the row is now a single six-column grid (packshot + 5 models), and the packshot fills its tile edge to edge (`object-fit:cover`, no padding/border), so all six tiles share one height (measured: 288px each).
- **Lightbox before/after unequal heights / white box.** The source packshot and the generated image opened at different heights, the packshot in a white box (`background:#fff`). Fixed: both panes use a fixed `height` (72vh) with `object-fit:contain` and no background box, so they are always the same height (measured: 648px each). The white that remains on a packshot is the product photo's own baked-in background, not a CSS box, and cannot be removed without re-cropping the source.
- **Deck still used Scenario "credits".** The method table and motion cards in `deck.html` quoted "~12 credits / ~3 credits / ~176 credits / ~120 to 400 credits"; converted to dollars (~$0.60 / ~$0.15 / ~$9 / ~$6 to $20) to match the dollars-not-credits rule and the site.

## Fixed in v5 (Mango edition, 2026-06-21)
- **Hero reel collapsed to 0 height.** Sizing the hero `.reelwrap` with `aspect-ratio` + `width:auto` + `justify-self:end` + an absolutely-positioned video gave the box no intrinsic size, so it rendered invisible (audio still played). Fixed with a definite `height:80vh; width:calc(80vh*9/16)` box and a non-absolute video at `object-fit:cover`. The whole 9:16 film now shows and never exceeds the viewport.
- **Reel opened on a black title card** (weak first impression). Fixed: the reel now opens on a model in the garment with the title overlaid; `poster="media/hero_s2.jpg"` covers the load.
- **No sound control.** Added a visible sound toggle button on the hero; sound also turns on after the first page gesture (browser autoplay policy blocks unmuted autoplay).
- **Stale geo images via browser cache.** v3 shipped red-satin geo at the same filenames as v4's jumpsuit geo, so browsers served the cached red-satin version (looked like a regression; the server was correct). Lesson: cache-bust or rename when content changes under an unchanged filename.
- **Legal overclaims removed** (grounded in DPA/MSA v2.2): "EU data residency" (false; US/AWS), indemnity-for-output (MSA 9.5 excludes it), "CCPA via SCCs" (it is service-provider terms), "Enterprise-Ready by default" (Order Form option). A 6-agent adversarial verification checked 60 claims.
- **Squished editorial stills in the reel** (interim): the first reel rebuild force-fit 2:3 stills into 9:16; replaced with blurred-fill, then the whole stills approach was dropped (reel is now video only).


Status as of 2026-06-21. "Documented" means it is surfaced honestly in the deliverable on purpose, not hidden.

## Fixed in v4 (2026-06-21)
- **PDF deck refreshed to v4 parity.** `deck.html` was rebuilt to match `index.html`: jumpsuit lead, new Every-brand page (own-label proof), 3-screenshot provenance strip, off-the-grey + Localize geo page, two-keyframe motion, measured pilot, accuracy/C10 page removed. Now 16 pages. New montages built: `media/hero_s2.jpg`, `geo_strip.jpg`, `brands_grid.jpg`, `provenance_strip.jpg`, `video_strip_s2.jpg`.
- **PDF page-clipping (deck `overflow:hidden`).** Two pages silently lost content because `.page{overflow:hidden}` clips overflow instead of paginating: (a) the full-width jumpsuit fidelity image pushed the C9 win card and QA callout off page 8 (fixed by capping the image at `max-height:330px`); (b) the appendix overran one page and clipped the cited cost sources (fixed by splitting the appendix across two pages). Lesson: in this deck, overflow is invisible data loss, not a scrollbar. QC every page after a content change.
- **Gemini stretched body proportions** on two full-body environment swaps (Tokyo, NYC geo): the figure was elongated (abnormal head-to-body and leg length). Fixed by redoing those placements with **GPT Image 2 img2img** (1024x1536, quality medium) with a prompt explicitly demanding natural proportions. Lesson: prefer GPT Image 2 over Gemini for full-body person-into-environment placement; Gemini is fine for light/background but can distort the body.
- **Video clips were static, then drifted.** first=last frame produced no motion (boring); single-first-frame let Seedance reinvent the garment (a dress grew into a full-length gown). Fixed with the **two-keyframe technique**: `image` = verified try-on still (pose A), `lastFrameImage` = a Gemini re-pose of the SAME garment mid-walk (pose B). Real walking motion, garment length pinned at both ends.
- **Own-brand render gap closed.** Was an intentional Phase-1 gap; now a real La Redoute Collections try-on scraped from the live site (ROADMAP item 1, done).
- **Accuracy/C10 section removed at client direction** ("everything is supposed to hold; no need to shoot ourselves in the foot"). The dedicated section and the explorer C10 "caveat" badge were removed; the positive colorway-win notes remain. The C10 source/render files stay in the repo, just unsurfaced.
- **Pruna `personImage` from a dressed still.** Brand try-ons reused the jumpsuit try-on stills as the person (Pruna re-dresses). No garment bleed observed; `preserveInputSize:true` kept natural proportions (unlike the Gemini geo stretch).

## Open / needs a call
- **Stale sizzle reels (pre-v4, red-satin-led).** `media/video/sizzle_16x9.mp4` and `sizzle_9x16.mp4` were built by `reel/build_reel.sh` from the OLD clips (red satin lead), before the v4 jumpsuit re-anchor. They are currently orphaned: neither `index.html` nor `deck.html` references them, so nothing contradictory plays today. BUT `README.md` lists them as part of the leave-behind package. If the reel is ever re-linked or rebuilt, it must be re-anchored to the jumpsuit first, or it contradicts the v4 site/deck. Decision needed: rebuild the reel jumpsuit-led (ffmpeg, no credits) or drop the reels from the package. See ROADMAP.

## Open / by design
- **C10 fidelity: silhouette substitution (DOCUMENTED).** The cropped short-sleeve striped shirt rendered as a long-sleeve, full-length tucked shirt and the blue stripe faded. Blazer and trousers held. v4: the dedicated accuracy section was REMOVED from BOTH the site and the PDF deck at the client's direction; the case still motivates the human-QA-gate copy (site Automate/Explorer; deck page-8 fidelity callout). It remains a real fidelity limitation: a tighter garment prompt plus the QA gate is the fix path. Source/render files stay in the repo, unsurfaced.
- **Body diversity is faces only.** All 5 models share one slim build. Not a render bug; a scope honesty point. Body-size range is a roadmap/pilot item (see ROADMAP).
- ~~**No own-brand render.**~~ RESOLVED in v4 (see "Fixed in v4"): a real La Redoute Collections try-on now ships in `#brands`.

## Fixed during build
- **GPT Image 2 output moderation** flagged a young woman in minimal grey tank+shorts as sexual (stochastic). Fixed by a more modest base wardrobe (crew tee + knee-length shorts) and "tasteful" in the prompt.
- **Pose wording**: "glance over shoulder" produced a back view (garment front hidden). Fixed to "facing camera, front of body toward camera".
- **C9 mislabeled SKU**: source "Jean large" is actually burgundy wide-leg trousers; reproduced correctly. Relabelled in copy as "wide-leg trousers". Source's wider flare rendered slightly straighter (minor).
- **Deck page 7 footer overlap**: the C10 comparison image was too tall and the last bullet touched the footer. Fixed by capping comparison image height (`.cmp img{max-height:300px}`).
- **Em dashes** slipped into the HTML `<title>` tags; removed (rule: no em dashes in any copy).

## Environment / tooling gotchas
- **ffmpeg has no `drawtext` filter** in this build (no libfreetype). All reel text is pre-rendered as PNG with ImageMagick and composited via `overlay` / concat. Do not reintroduce `drawtext`; it will fail.
- **ffmpeg concat demuxer** resolves `file` paths relative to the list file's own directory. The list must reference segment basenames, not a `seg/` prefix.
- **Scenario MCP `display_asset`** must be called with `format="json"` for bulk URL collection; default returns the inline image and floods context. Always pass `team_id` and `project_id`.
- **Collection at scale**: subagents stall on long (50+) sequential job-check/download loops (600s stream watchdog). Keep batches small (<=15) and strictly sequential; downloads persist on disk so re-dispatch fills gaps.
- **GPT Image 2 high quality** sits at progress 0 for ~5 min (looks hung, usually completes). Use medium (~45s) for fleets.

## Microsite notes (not bugs)
- Explorer images are `loading="lazy"`; a full-page screenshot may show empty cells until scrolled. Real browsers load on scroll.
- The hero reel autoplays muted (browser autoplay policy). Sound requires a user click; the on-video tag says "tap for sound".
- A `favicon.ico` 404 appears in console; cosmetic. Add a favicon to silence it (see ROADMAP).
