# BUGS and known issues

Status as of 2026-06-21. "Documented" means it is surfaced honestly in the deliverable on purpose, not hidden.

## Fixed in v4 (2026-06-21)
- **Gemini stretched body proportions** on two full-body environment swaps (Tokyo, NYC geo): the figure was elongated (abnormal head-to-body and leg length). Fixed by redoing those placements with **GPT Image 2 img2img** (1024x1536, quality medium) with a prompt explicitly demanding natural proportions. Lesson: prefer GPT Image 2 over Gemini for full-body person-into-environment placement; Gemini is fine for light/background but can distort the body.
- **Video clips were static, then drifted.** first=last frame produced no motion (boring); single-first-frame let Seedance reinvent the garment (a dress grew into a full-length gown). Fixed with the **two-keyframe technique**: `image` = verified try-on still (pose A), `lastFrameImage` = a Gemini re-pose of the SAME garment mid-walk (pose B). Real walking motion, garment length pinned at both ends.
- **Own-brand render gap closed.** Was an intentional Phase-1 gap; now a real La Redoute Collections try-on scraped from the live site (ROADMAP item 1, done).
- **Accuracy/C10 section removed at client direction** ("everything is supposed to hold; no need to shoot ourselves in the foot"). The dedicated section and the explorer C10 "caveat" badge were removed; the positive colorway-win notes remain. The C10 source/render files stay in the repo, just unsurfaced.
- **Pruna `personImage` from a dressed still.** Brand try-ons reused the jumpsuit try-on stills as the person (Pruna re-dresses). No garment bleed observed; `preserveInputSize:true` kept natural proportions (unlike the Gemini geo stretch).

## Open / by design
- **C10 fidelity: silhouette substitution (DOCUMENTED).** The cropped short-sleeve striped shirt rendered as a long-sleeve, full-length tucked shirt and the blue stripe faded. Blazer and trousers held. v4: the dedicated accuracy section was REMOVED from the site at the client's direction; the case still motivates the human-QA-gate copy in Automate/Explorer and still appears in the PDF deck until that is refreshed. It remains a real fidelity limitation: a tighter garment prompt plus the QA gate is the fix path.
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
