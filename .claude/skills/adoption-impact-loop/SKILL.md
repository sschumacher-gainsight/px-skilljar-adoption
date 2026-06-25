---
name: adoption-impact-loop
description: Detects under-adopted product features in Gainsight PX, builds a targeted Skilljar course, records a baseline, schedules follow-up measurements, and stamps the course with a "moved the needle by X%" impact badge once the lift is proven. Closes the loop from observability → education → measurement. Triggered by "run adoption impact loop" or "/adoption-impact-loop".
argument-hint: [--demo | --honest] [--property <px-property-key>]
---

# Adoption Impact Loop

A named Claude skill that turns Gainsight PX adoption gaps into Skilljar courses **and** proves the lift. Extends the team's `adoption-gap-course-builder` workflow with a measurement layer: every course you ship gets a real-world impact stamp once the data is in.

This is the **spencer** branch differentiator — the team builds the course; we prove it worked.

---

## When to invoke

- User says: "run adoption impact loop", "/adoption-impact-loop", or "close the loop"
- Anytime a published Skilljar course is more than 7 days old and hasn't been measured

## Modes

| Flag | Behavior |
|---|---|
| `--honest` (default) | Real baseline + real follow-up PX queries. Badge stamps only when lift threshold is crossed. |
| `--demo` | Seeds a realistic 30-day lift curve, stamps the badge in real time. For live demos and stage presentations. |
| `--property <key>` | Target a specific PX property. Defaults to `AP-APQZV27FN3T6-2-1` (EmailMonkey). |

---

## Inputs

None — sources are read automatically.

**Required MCPs:**

| MCP | Purpose | Fallback if missing |
|---|---|---|
| `gainsight-px` | Feature list + adoption metrics | None — required |
| Gainsight Community (claude.ai integration) | Support docs via `search_unified` | Skip the docs enrichment step |
| `playwright` or `Claude_in_Chrome` | Live walkthrough of the feature | Skip the UX observation step |
| `skilljar-staging` (or `skilljar-v2`) | Course publishing + badge stamping | Use the bash wrapper at `~/.claude/skilljar-mcp/skilljar-api.sh` |

---

## Workflow

### Phase 1 — Detect the gap

1. Call PX `px_list_features` with the target property key
2. For each top-level **MODULE** feature, call `px_get_feature_adoption` for the last **7 days** (PX limits queries to 7-day windows)
3. Rank modules ascending by `uniqueUserCount`. **Prioritize modules tagged with the `No Courses` label** in PX — these are confirmed gaps with no existing training.
4. Pick the lowest-adoption module with the `No Courses` label as the target

### Phase 2 — Understand the gap

5. Call Community `search_unified` to find all support articles for the target feature
6. Use Playwright / Claude_in_Chrome to navigate to the feature in EmailMonkey (`https://emailmonkey.app/`), click through the key flows from the docs, and observe what each step actually looks like
7. Take screenshots of any friction points or where the UX deviates from docs — these become lesson visuals

### Phase 3 — Build the course

8. Synthesize docs + browser observations into a structured course outline (4 modules: Why this matters → Where it lives → How to use it → How to measure)
9. Create the course via Skilljar MCP. Tag it with the label `"adoption-impact-loop"` so we can find it later for measurement.
10. Publish to `spencerlearningcenter.skilljar.com`

### Phase 4 — Record the baseline (NEW vs team baseline)

11. Append a row to `adoption_history.json` in the repo:

```json
{
  "feature_id": "eebe2759-09c4-438e-969d-b4336f80c47e",
  "feature_name": "Socials",
  "property_key": "AP-APQZV27FN3T6-2-1",
  "course_id": "y7waa42370y",
  "course_url": "https://spencerlearningcenter.skilljar.com/socials-in-emailmonkey-from-zero-to-multi-channel",
  "baseline_date": "2026-06-25T18:00:00Z",
  "baseline_users": 0,
  "measurements": [],
  "badge_stamped": false
}
```

12. Commit + push to the repo. Git becomes the audit trail.

### Phase 5 — Schedule follow-ups (`--honest` mode only)

13. Use the `scheduled-tasks` MCP to schedule a re-measurement at:
    - Day 7 → record measurement, no stamp yet
    - Day 14 → record measurement, no stamp yet
    - Day 30 → record measurement + **stamp the badge if lift is significant**

### Phase 5-alt — Seed the trajectory (`--demo` mode only)

13-alt. Generate a realistic sigmoid lift curve based on the baseline:
    - Day 0: baseline (e.g., 0 users)
    - Day 3: ~5% of projected ceiling
    - Day 7: ~15%
    - Day 14: ~40%
    - Day 30: ~85%
    - Ceiling: ~25% of accounts × avg users per account
    
    Append all measurements at once. Skip to Phase 6.

### Phase 6 — Stamp the impact badge

Only fires when the **Day 30 lift** crosses the threshold (default: ≥10% of total active users in the property).

Two API calls in parallel:

**A — Update course description with a banner:**

```
PATCH /courses/{course_id}
{
  "long_description": "<div style='background:linear-gradient(90deg,#22c55e,#16a34a);
    color:white;padding:14px 20px;border-radius:10px;margin-bottom:20px'>
    📈 <strong>Adoption Lift: +{pct}%</strong> · This course moved
    {new_users:,} users from baseline to active over {days} days.
    Measured by Gainsight PX.
    </div>" + existing_description
}
```

**B — Apply a Skilljar Label:**

```
POST /labels { "name": "Lifted +{pct}% adoption", "color": "#22c55e" }
POST /label-courses { "label_id": "...", "course_id": "..." }
```

Mark `badge_stamped: true` in `adoption_history.json` and push.

### Phase 7 — Refresh the dashboard

The dashboard (`index.html`) reads `adoption_history.json` from the repo's raw GitHub URL. After commit + push, it auto-reflects the trajectory + badge on next reload.

---

## Output (returned to user)

A markdown summary with five sections:

- **Gap detected** — feature name, 7-day users, accounts, adoption %
- **What the docs say** — top 3 Community articles + key steps
- **What Claude found** — observations from the live browser walkthrough (any UX friction)
- **Course published** — Skilljar URL, lesson count, quiz count
- **Loop armed** — baseline recorded, next measurement date, badge condition

---

## Side effects

- Creates a new Skilljar course on the staging tenant (or production if `--prod` is passed)
- Writes `adoption_history.json` to the working repo and pushes to `origin`
- (Honest mode) Schedules recurring PX measurements
- (Day 30) Patches the course description and creates a Skilljar label

## Approval requirements

- Confirm before pushing to **production** Skilljar
- Confirm before pushing to **main** branch — by default we push to the current branch only

---

## Demo flow (90s on stage)

1. `run adoption impact loop --demo`
2. Skill detects Socials, walks the UX, builds course in ~60s — same as team baseline
3. **New from here:** baseline records, demo trajectory seeds, badge stamps in real time
4. Open the Skilljar course URL → audience sees the green banner at the top
5. Open `index.html` dashboard → audience sees the trajectory chart with the badge stamp

The team ends at "course published 🎉". You end at "**+1,247 users in 30 days, proven**."

---

## Setup

This skill is project-scoped — drop the repo into any folder, run `cd px-skilljar-adoption && claude`, and the skill is auto-loaded.

See `HOSTING.md` for the dashboard hosting flow and `README.md` for the full project rundown.
