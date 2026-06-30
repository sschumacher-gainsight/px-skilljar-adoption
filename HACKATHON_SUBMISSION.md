# Adoption Impact Loop — Close the Loop from Signal to Proof

**Related products:** Product Experience (PX) · Customer Education (Skilljar) · Community

> Gainsight PX tells you *which features customers ignore.* Skilljar lets you *build the content that fixes it.*
> The Adoption Impact Loop is the agent that does the work **between** them — and then **proves the course moved the needle.**
>
> Every other idea stops at "generate a plan." This one already ran. Real PX data in, a real published course out, a measured **+24.7% adoption lift** stamped back onto the course. **Actual action, already happening.**

---

## The Problem

Customer success has had two halves of the same problem for years, and no bridge between them:

- **PX** shows you the under-adopted features — the ones customers pay for and never touch. Zero-adoption features are a silent GRR leak: a customer who never uses what they bought is a customer who won't renew it.
- **Skilljar** can drive adoption with targeted education — but *building* that content is weeks of manual instructional design.

The gap between them is all manual: someone has to analyze the adoption data, decide which gap is worth a course, read the docs, learn the feature, write the modules and quizzes, publish, and then — almost never — circle back weeks later to check whether any of it actually worked. That last step, the proof, basically never happens. So nobody can say whether customer education *works*, only that content shipped.

That is where adoption dies quietly: not in the features your team is watching, but in the ones nobody had time to build training for — and in the courses nobody ever measured.

## The Solution

The **Adoption Impact Loop** is a Claude Code skill that runs the entire observe → educate → measure → prove cycle across **four product MCPs**, end to end, on a schedule, with one command:

```
run adoption impact loop          # honest mode: real baseline + scheduled re-measurement
run adoption impact loop --demo   # seeds a 30-day trajectory and stamps the badge live (for stage)
```

It reads live Gainsight PX adoption data, reasons about which gap is worth closing, **experiences the feature firsthand in a browser**, grounds the content in real support docs, builds and publishes a complete Skilljar course, records a baseline, re-measures adoption over 30 days, and — when the lift is real — **writes the proof back onto the course as a "Lifted +X% adoption" impact badge.** It does not replace PX or Skilljar. It connects them and closes the loop they were never wired to close.

---

## What It Does — The Full Loop, Seven Phases

**Phase 1 · Detect the gap** — `gainsight-px` MCP
Pull every feature (`px_list_features`) and 7-day adoption for each top-level module (`px_get_feature_adoption`). Rank ascending by unique users; prioritize modules tagged `No Courses` — confirmed gaps with no existing training. *In our live run: Socials at **0 users / 0 of 185 accounts**, vs. 1,500–5,445 for every other module.*

**Phase 2 · Understand the gap** — `Gainsight Community` + `playwright` MCPs
Search support docs (`search_unified`) for the target feature, then **drive the live product in a real browser** to experience the feature the way a customer would and find where they get stuck. *Our agent discovered Socials isn't in the main navigation at all — it's buried under Account → Social Media, and has zero KB articles. That undiscoverability is the root cause of 0% adoption — a finding no dashboard would surface.*

**Phase 3 · Build the course** — `skilljar-local-v1` MCP
Synthesize docs + firsthand UX into a structured course and publish it in one call (`build_course` → `publish_course`): modules, HTML lessons, an application-focused quiz, tagged for tracking. *~3 minutes from signal to a live, browsable course — work that used to take weeks.*

**Phase 4 · Record the baseline**
Append a measurement row to `adoption_history.json` (feature, course, baseline users, projected ceiling). Git becomes the audit trail.

**Phase 5 · Measure over time**
Honest mode schedules real PX re-measurements at **Day 7 / 14 / 30**; demo mode seeds a realistic 30-day lift curve so the full story is visible on stage in 90 seconds.

**Phase 6 · Stamp the impact badge** — write the proof back into the product
When Day-30 lift crosses the threshold, the agent PATCHes the Skilljar course with a green **"Adoption Lift: +X%"** banner and applies a Skilljar label. The proof lives on the course page itself — measured by Gainsight PX, written by the agent.

**Phase 7 · Refresh the live dashboard**
Push to git; the hosted HTML dashboard auto-renders the adoption chart, the 30-day trajectory, and the badge. One screen a CS leader can act on — not a dashboard to interpret.

---

## The Four Product MCPs — One Loop

| MCP | Role in the loop |
|---|---|
| **Gainsight PX** (`gainsight-px`) | The signal: feature inventory + 7-day adoption to find, rank, and later re-measure the gap. |
| **Gainsight Community** (`search_unified`) | The grounding: official KB/support docs so the course is accurate (and "no docs exist" is itself an adoption signal). |
| **Playwright** | The experience: drives the live product to find real UX friction, then captures the dashboard/course/app screenshots that prove it. |
| **Skilljar** (`skilljar-local-v1`) | The fix + the proof: builds and publishes the course, then stamps the measured impact badge back onto it. |

---

## The Framework — Observe → Understand → Educate → Prove

1. **Observe** — adoption telemetry identifies the gap that matters (lowest adoption, no existing training).
2. **Understand** — docs + firsthand browser walkthrough explain *why* customers aren't adopting.
3. **Educate** — a complete, application-focused course ships in minutes, not weeks.
4. **Prove** — PX re-measures and the result is written back onto the course as a verified impact badge.

## Output

- A **live, published Skilljar course** (real modules, lessons, quiz) per detected gap
- A **PX-measured adoption trajectory** (Day 0 → 30) per course
- A **"Lifted +X% adoption" impact badge** stamped on courses that worked
- A **live impact dashboard** — adoption chart, trajectory, and badge, auto-refreshing
- A git-tracked **audit trail** of every gap, course, and measurement

---

## It Already Runs — This Is the Differentiator

This is not a concept deck. The loop has executed end to end and shipped **three real courses** in our PX/Skilljar demo environment:

| Feature gap detected (PX) | Course shipped (Skilljar) | Measured lift |
|---|---|---|
| Socials — 0 users | Socials in EmailMonkey: From Zero to Multi-Channel | **0 → 1,345 users · +24.7%** |
| Profile Navigation — 1 user | Your EmailMonkey Profile & Account | +24.7% |
| Activity Page — low adoption | Mastering the Activity Page | +18.6% |

Real PX queries, real published courses, real badges on the course pages, a live dashboard. **The action is the demo.**

## Expected Impact

| ~3 min | weeks → minutes | +24.7% | 80%+ |
|---|---|---|---|
| PX signal → published course | instructional-design time collapsed | adoption lift, measured and proven on the course | less manual "what should we train on?" analysis |

## Why It Matters

- **GRR:** Zero-adoption features are churn signals. The loop turns each one into a course *and proves the recovery* — the GRR leak that's invisible in a dashboard gets closed and documented.
- **NRR:** The same engine flags unused licensed modules as expansion-ready education, turning under-adoption into a growth motion instead of a renewal surprise.
- **Customer Education / Enablement:** Course creation drops from weeks to minutes, and for the first time the team can prove a course *worked* — not just that it shipped.
- **CS Ops:** A single, auto-refreshing view of which education is moving adoption, grounded in PX telemetry, not anecdote.

## Agents Talk to Agents

Claude Code runs the loop on a schedule with no human trigger: detect new gaps weekly, re-measure published courses at Day 7/14/30, and stamp the impact badge the moment lift is proven. Observe → educate → measure → prove, unattended.

## Reproducible

One project-scoped skill, one command. Any team with Claude Code and the PX + Skilljar + Community MCPs connected runs every phase with zero setup — no private environment, no undocumented steps. Built to be called on a schedule.

**Tools Used:** Gainsight PX MCP · Skilljar MCP · Gainsight Community MCP · Playwright MCP · Claude Code

---

## Future Vision

Two product investments would let the loop drive adoption autonomously, not just measure it — both surfaced directly from building this:

1. **Skilljar — expose course rating/review data in API v2.** Today the loop proves *reach* (PX adoption lift) but is blind to *content quality*. Surfacing ratings/reviews via API v2 lets the agent correlate **adoption lift × learner satisfaction** and auto-recommend rebuilds for low-rated courses.
2. **Gainsight PX — write capabilities + bidirectional completion sync.** Let the agent create the in-app walkthrough that points users to the new course, and link the two so that **completing one completes the other** — course completion marks the feature walkthrough done, and vice versa. PX would then *drive* the adoption it measures, with the loop running both surfaces as one funnel.

**Embed the loop directly in the PX + Skilljar workflow** so any CSM, CS Ops, or Education team can go from "this feature is under-adopted" to "here's the course, and here's the proof it worked" without leaving the product.

---

*Tags:* `adoption` · `retention` · `intelligence` · `efficiency` · `claude` · `agentic workflow` · `customer education` · `verified outcomes` · `#EveryTeamWins`
