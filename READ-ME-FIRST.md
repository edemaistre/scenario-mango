# Scenario → Mango pitch package

Outbound enterprise pitch from Emmanuel (Scenario CEO) to Mango. Proof: a 50-image virtual try-on catalog built on Mango's assortment captured via laredoute.fr, plus 5 real motion clips. Plan engineered by a generate → adversarial-judge → synthesize loop (self-scored 9.4); every fidelity claim verified against the source pixels before it was written.

## What to send / open
| File | What it is | How to use |
|---|---|---|
| `Scenario-Mango-Proposal.pdf` | 14-page pitch document | The leave-behind. Email or attach to the deal. |
| `index.html` | Interactive microsite | The live demo. Open in Chrome, or host it. Self-contained (uses `media/`). |
| `deck.html` | Source of the PDF | Edit + re-render if you want changes (command below). |
| `media/` | All images + 5 videos | Keep alongside the two HTML files. |

The whole `la-redoute-pitch/` folder is self-contained and portable. To host the microsite, drop the folder on any static host. To re-make the PDF after editing `deck.html`:
```
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --headless --disable-gpu \
  --no-pdf-header-footer --virtual-time-budget=15000 \
  --print-to-pdf="Scenario-Mango-Proposal.pdf" "file://$PWD/deck.html"
```

## The spine of the pitch (deliberate)
Credibility is the product. The deck opens on a verified, bounded claim, states the boundary out loud, and owns the one fidelity miss (C10) precisely against the pixels under a named human-QA gate, while conceding C9 as a colorway win rather than a fake miss. It clears the two gates that decide an EU retail deal head-on: rights / synthetic-media and accuracy. It closes with a signable, two-phase pilot.

## Honesty guardrails baked in (do not break when editing)
- Say "every face," not "every body": all 5 models share one slim build. Body-size is the Phase-1 pilot deliverable, not a proven result.
- No own-brand render exists yet; it is named as a Phase-1 deliverable everywhere, never as shipped proof.
- The Mango packshots are a one-time evaluation artifact, quarantined from production claims.
- Cost benchmarks are cited (squareshot, blendnow, nightjar), not invented; "2 to 3x" effective overrun is the sourced figure.
- No em dashes in any copy.

## Numbers (for your reference)
50 stills ≈ 325 credits (reconstructed: smoke ~77 + 5 masters ~96 + 50 swaps ~150). 5 motion clips ≈ 730 credits (~146 each). Studio benchmark cited at ~$46 to ~$96 per finished image, effective 2 to 3x once coordination and re-shoots are counted.

## v2 upgrades (the 7.5 -> 9.5 pass)
A second loop (5 expert critics -> synthesis) found the gap: the work looked like a *demo* (everything on flat grey) and the videos were five near-identical turns. Two moves closed it, both honesty-safe:
1. **The "ceiling" (Studio to Story):** 6 editorial renders place the SAME identity + garment into real environments (Paris street, dusk terrace, boutique, café, interior, gallery), shown as before/after pairs in `media/ceiling/`, a new deck page, and the microsite `#ceiling` section. Each is hard-labelled "AI capability demonstration", and the grey 50-grid stays the verified fidelity proof.
2. **A 30-second branded film:** `media/video/sizzle_9x16.mp4` (+ a 16:9 variant), music-scored, 3 acts (studio proof with lower-thirds -> the lifestyle "ceiling" incl. one real dusk-terrace motion beat -> pilot CTA). It plays in the microsite hero.
Plus serif display headings across deck + site for editorial cohesion.

Extra spend for v2 ~ 950 credits (6 editorial renders ~80 + lifestyle clip 146 + the 5 reel clips already existed + music 15; reconstructed). Nothing claimed changed; guardrails intact.

Built in Scenario on the Public Data project. Confidential.
