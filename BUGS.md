# BUGS and known issues

Status as of 2026-06-20. "Documented" means it is surfaced honestly in the deliverable on purpose, not hidden.

## Open / by design
- **C10 fidelity: silhouette substitution (DOCUMENTED, not fixed).** The cropped short-sleeve striped shirt rendered as a long-sleeve, full-length tucked shirt and the blue stripe faded. Blazer and trousers held. This is shown in the deck/site as the reason a human-QA gate is mandatory. Fix path: tighter garment prompt + the QA gate catching it pre-publish. Do not quietly "fix" by hiding it; it is load-bearing for the pitch.
- **Body diversity is faces only.** All 5 models share one slim build. Not a render bug; a scope honesty point. Body-size range is a roadmap/pilot item (see ROADMAP).
- **No own-brand render.** Intentional gap, labelled Phase-1 everywhere.

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
