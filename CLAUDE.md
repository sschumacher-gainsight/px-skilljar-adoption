# Adoption Gap Course Builder

A named Claude tool that detects under-adopted product features, reads the support documentation, experiences the feature firsthand via browser, and publishes a complete Skilljar course — automatically.

---

## run adoption gap course builder

**Trigger:** `run adoption gap course builder`

**Inputs:** none — all sources are read automatically

**Sources:**
- Gainsight PX MCP (`gainsight-px`) — feature list + 7-day adoption data for EmailMonkey (`propertyKey: AP-APQZV27FN3T6-2-1`)
- Gainsight Community MCP (`gainsight-community`) — support docs via `search_unified`, filtering by `sources: ["zendesk", "salesforce", "freshdesk"]` for official KB articles
- Playwright MCP (`playwright`) — live walkthrough of the feature in the EmailMonkey demo app (`https://emailmonkey.app/`)
- Skilljar MCP (`skilljar`) — course creation on the staging tenant

**Logic:**
1. Call PX MCP `px_list_features` for `AP-APQZV27FN3T6-2-1` to get all features
2. Call PX MCP `px_get_feature_adoption` for each top-level MODULE feature for the last 7 days (`dateRangeStart`: 7 days ago midnight UTC, `dateRangeEnd`: today midnight UTC)
3. Rank modules by unique users (ascending). Prioritize modules with the `No Courses` label — these are confirmed gaps with no existing training content
4. Select the lowest-adoption module with the `No Courses` label as the target
5. Call Gainsight Community MCP `search_unified` to find all support articles and documentation related to the target feature name
6. Use Playwright MCP to navigate to the feature in EmailMonkey, click through the key flows described in the support docs, and record what each step actually looks like and does — note any gaps between docs and reality
7. Synthesize the support docs + firsthand browser experience into a structured course outline: modules, lessons, quiz questions based on real UI steps
8. Call Skilljar MCP to create the course, lessons, and quizzes
9. Return a summary: feature targeted, adoption data, course URL, and a one-paragraph explanation of why this feature had low adoption based on the docs/UX findings

**Output:**
Markdown summary with four sections:
- **Gap detected** — feature name, 7-day users, accounts, adoption %
- **What the docs say** — key steps from Community support articles
- **What Claude found** — observations from the live browser walkthrough (any friction, missing steps, confusing UI)
- **Course published** — Skilljar course URL, lesson count, quiz count

**Side effects:**
- Creates a new course in Skilljar staging tenant with lessons and quizzes

**Approval:**
- Confirm before publishing to production Skilljar tenant (staging is automatic)

---

## Setup

### Required MCP servers

Add all four to your `~/.claude.json` under `mcpServers`:

```json
{
  "mcpServers": {
    "skilljar": {
      "type": "http",
      "url": "https://mcp.skilljar.com/mcp"
    },
    "gainsight-px": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.aptrinsic.com/mcp"]
    },
    "playwright": {
      "type": "stdio",
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    }
  }
}
```

Restart Claude Code after editing. The PX MCP uses OAuth — a browser window will open on first use to authenticate.

The Gainsight Community MCP connects via the claude.ai integration and does not require a local MCP entry.

### Product key reference
| Product | Key |
|---------|-----|
| EmailMonkey (main) | `AP-APQZV27FN3T6-2-1` |

---

## GRR / NRR connection

Features with zero or near-zero adoption are churn risk signals. A customer who never uses a feature they paid for is a customer who won't renew it. This tool closes the loop:

1. **PX detects the gap** — zero adoption, confirmed no existing course
2. **Claude understands the gap** — reads the docs, walks the feature, finds where customers get stuck
3. **Skilljar closes the gap** — a complete course ships in minutes, not weeks
4. **PX measures the result** — adoption data the following week shows whether the course moved the needle

This is the observability -> education -> measurement loop that directly protects GRR and drives NRR through feature expansion.

---

## Spencer's extension: Adoption Impact Loop skill

The team baseline ends at step 3 (course published). The `spencer` branch adds step 4 as a real, runnable skill — not just an idea.

**Trigger:** `run adoption impact loop` or `/adoption-impact-loop`

**What it does beyond the team baseline:**

- Records a baseline measurement in `adoption_history.json` at course publish time
- Schedules follow-up PX queries at Day 3 / 7 / 14 / 30 (or seeds a realistic curve in `--demo` mode)
- When the lift threshold is crossed at Day 30, **stamps the Skilljar course with a "Lifted +X% adoption" impact badge** — green banner on the course page, plus a structured Skilljar label
- Dashboard auto-renders the trajectory chart and the badge

**Where it lives:** `.claude/skills/adoption-impact-loop/SKILL.md` — project-scoped, auto-loaded when you run Claude Code in this repo.

**Helper scripts:** `.claude/skills/adoption-impact-loop/scripts/`
- `seed_demo_trajectory.py` — generates a sigmoid lift curve for live demos
- `stamp_impact_badge.sh` — PATCH the course description + apply Skilljar label

**Demo mode (live on stage):**
```
run adoption impact loop --demo
```
Detects gap → builds course → records baseline → seeds 30-day trajectory → stamps badge — all in one go.

This is the differentiation: the team builds the course; the loop proves it worked.
