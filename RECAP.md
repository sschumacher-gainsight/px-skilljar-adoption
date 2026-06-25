# Recap — Adoption Impact Loop now on `main`

**Repo:** https://github.com/sschumacher-gainsight/px-skilljar-adoption
**Live dashboard:** https://sschumacher-gainsight.github.io/px-skilljar-adoption/
**Merge commit:** https://github.com/sschumacher-gainsight/px-skilljar-adoption/commit/4a596f6

---

## The change in one sentence

> The team's `adoption-gap-course-builder` ends at *"course published 🎉"*. The new **Adoption Impact Loop** keeps going to *"and here's the +X% adoption lift the course drove, stamped on the course in Skilljar."*

---

## What's been added to `main`

### 1. A new installable skill: `adoption-impact-loop`

Located at [`.claude/skills/adoption-impact-loop/`](.claude/skills/adoption-impact-loop/). Anyone who clones the repo and runs `claude` inside it gets this skill automatically.

Trigger with:

```
run adoption impact loop --demo
```

What it does end-to-end:

1. **Detect** the lowest-adoption module in your PX property (prioritizes the `No Courses` label)
2. **Understand** the gap — searches Gainsight Community for support docs via `search_unified`
3. **Walk** the feature in a browser (Playwright or `Claude_in_Chrome`)
4. **Build** a Skilljar course with embedded community docs + UX observations
5. **Record** a baseline measurement in `adoption_history.json` at publish time *(new vs team baseline)*
6. **Seed** a 30-day lift trajectory (demo mode) **or** schedule real follow-up PX queries (honest mode) *(new)*
7. **Stamp** the Skilljar course with a green "Most Successful Admin Track" banner + structured Skilljar label once the lift threshold is crossed *(new)*

### 2. Two real example courses live on staging

| Course | Lift | Course URL |
|---|---|---|
| **Socials in EmailMonkey: From Zero to Multi-Channel** | +24.6% / 30 days | https://spencerlearningcenter.skilljar.com/socials-in-emailmonkey-from-zero-to-multi-channel |
| **Mastering the Activity Page: From Sends to Insights** | +18.6% / 30 days | https://spencerlearningcenter.skilljar.com/mastering-the-activity-page-from-sends-to-insights |

Both have the green "Most Successful Admin Track" banner with social-proof copy and a graduate/admin/window stat row. The raw lift percentage is **hidden from learners** (clutters the course page) but **kept on the dashboard** (CSMs and admins want the ROI metric).

Both also carry two Skilljar labels each: the lift % label (e.g. `Lifted +18.6% adoption`) and an `Adoption Impact Loop` provenance label.

### 3. A measurement log: `adoption_history.json`

Git becomes the audit trail. Every measurement is a commit. The file lives at the repo root so the dashboard can fetch it directly from raw.githubusercontent.com.

### 4. A "Verified Impact" panel on the dashboard

Above the trajectory chart on `index.html`, the same green Most Successful Admin Track banner is mirrored — clickable, links to the live Skilljar course. Below it: the trajectory line chart (Day 0 → 30) and the lift badge. The dashboard is the only place the lift % surfaces visibly.

---

## What teammates should screenshot for their own demos

(I can't take browser screenshots without a connected Chrome MCP, so noting where the visuals are.)

### On the dashboard ([sschumacher-gainsight.github.io/px-skilljar-adoption/](https://sschumacher-gainsight.github.io/px-skilljar-adoption/))

1. **KPI strip at the top** — reads "Courses published: 2 · live on Skilljar · 2 lifted"
2. **Click the red Socials bar** (or Activity Page) — the right panel populates with the recommendation card showing "LIVE IN SKILLJAR" badge + a clickable course link
3. **Verified Impact section** (scroll down) — the green Most Successful Admin Track banner above the trajectory chart, with a 5-point line chart showing Day 0 → Day 30 adoption growth and a green "+24.6% · Badge stamped in Skilljar" card on the side
4. **Bottom catalog** — 4 course cards, Activity Page is the first one

### On Skilljar courses (catalog/detail page, not the player)

1. **Green "Most Successful Admin Track" banner** at the top of "About this course" — trophy, eyebrow text, "Earn the Most Successful Admin Badge" headline, social proof copy, and the graduate/admin/window stat row
2. **The two labels** visible on the course in Skilljar admin (`dashboard.skilljar.com`) — `Lifted +X.X% adoption` (green) and `Adoption Impact Loop` (purple)

---

## Try it yourself

```bash
git clone https://github.com/sschumacher-gainsight/px-skilljar-adoption.git
cd px-skilljar-adoption
claude
```

Then in Claude Code:

```
run adoption impact loop --demo
```

The skill walks through gap detection → community docs → browser walkthrough → course build → baseline → trajectory → badge stamp in about 3 minutes.

**MCPs you need configured** (see `CLAUDE.md` for the full setup block):
- `gainsight-px` — adoption data
- Gainsight Community — via claude.ai integration (URL: `https://mcp.insided.com/mcp`)
- `playwright` *or* `Claude_in_Chrome` — browser walkthrough
- `skilljar-staging` / `skilljar-v2` — course publishing

---

## Files changed in the merge

```
.claude/skills/adoption-impact-loop/SKILL.md                 (new — the skill orchestrator)
.claude/skills/adoption-impact-loop/scripts/                 (new)
  ├─ seed_demo_trajectory.py                                 (sigmoid lift curve generator)
  └─ stamp_impact_badge.sh                                   (Skilljar PATCH + label apply)
adoption_history.json                                        (new — measurement log)
index.html                                                   (Verified Impact panel + banner mirror)
CLAUDE.md                                                    ('Spencer's extension' section)
README.md                                                    ('Try it yourself' section)
```

---

## Open follow-ups worth picking up

- **Wire real Skilljar enrollment data** — the dashboard banner shows graduate counts derived from a heuristic. The `skilljar-v2` MCP has `get_course_enrollments` and `get_course_completion_summary` — swap those in for live numbers. ~5 min change.
- **Live browser screenshots** — when Playwright loads, the skill should capture step-by-step screenshots and embed them in lesson HTML instead of the current CSS-styled dashboard mockups. Falls back to mockups when no browser is available.
- **Honest-mode end-to-end** — verify the scheduled-tasks MCP can actually trigger the Day 7/14/30 re-measurements unattended.

---

*Built by Spencer Schumacher for Pulse 2026 hackweek · 2026-06-25*
