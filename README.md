# PX × Skilljar: Adoption Gap Engine

> Turn Gainsight PX feature-adoption signals into shippable Skilljar courses — in one click, in under three minutes.

**Pulse 2026 conference demo · Gainsight**

---

## 🎯 The idea

Customer success teams have always had two halves of the same problem:

1. **PX** tells you which features your customers are ignoring.
2. **Skilljar** lets you build content that drives them to try those features.

The missing piece was the work *between* the two — analyzing the adoption data, deciding which gap is worth a course, designing the modules and quizzes, and publishing the result.

This demo fills that gap with a Claude-powered agent.

---

## 🧭 Workflow

```
┌────────────────────┐    ┌────────────────────┐    ┌────────────────────┐
│  Gainsight PX MCP  │ →  │  Claude (Sonnet)   │ →  │   Skilljar MCP     │
│                    │    │                    │    │                    │
│  130 features      │    │  Rank by adoption  │    │  Create course     │
│  5 products        │    │  Pick the gap      │    │  18 lessons        │
│  7-day usage data  │    │  Generate outline  │    │  4 quizzes         │
│                    │    │  Write content     │    │  Publish to domain │
└────────────────────┘    └────────────────────┘    └────────────────────┘
                                    │
                                    ▼
                          ┌────────────────────┐
                          │  Live HTML         │
                          │  dashboard         │
                          │                    │
                          │  Click → recommend │
                          │  Click → create    │
                          └────────────────────┘
```

---

## 📊 What the data found

The PX MCP returned adoption for every feature set in our EmailMonkey demo property over the last 7 days. Three feature sets stood out:

| Feature Set | Users (7d) | Accounts | Verdict |
|---|---|---|---|
| EmailMonkey root | 5,061 | 183 | ✅ Healthy |
| Campaigns Page | 5,061 | 183 | ✅ Healthy |
| Templates | 2,564 | 180 | ✅ Healthy |
| Activity Page | 1,763 | 179 | 🟡 Moderate |
| Integration Page | 1,596 | 178 | 🟡 Moderate |
| **Socials** | **0** | **0** | 🔴 **Zero adoption** |
| Community Integrations | 1 | 1 | 🔴 Near-zero |
| Training (Courses) | 0 | 0 | 🔴 Zero adoption |

**The pick: Socials.** A fully-built EmailMonkey module — calendar, cross-post, brand handles — that 183 customer accounts had never once touched. Perfect demo target.

---

## 📚 What got built in Skilljar (live)

A complete, browsable course on the Skilljar staging tenant:

**[Socials in EmailMonkey: From Zero to Multi-Channel →](https://spencerlearningcenter.skilljar.com/socials-in-emailmonkey-from-zero-to-multi-channel-1)**

| | |
|---|---|
| Lessons | 18 total (4 module SECTIONs · 9 HTML lessons · 4 QUIZ lessons · 1 Final Project) |
| Quizzes | 4 · 80% pass · unlimited attempts |
| Questions | 16 multiple-choice — all application-focused, no recall |
| Final Project | Ship a real cross-channel campaign · 4-criterion rubric |
| Build time | ~3 minutes via parallel MCP calls |

### Module outline

1. **Why Socials matters** — quantify the multi-channel lift, find the module in EmailMonkey
2. **Connect your social accounts** — link LinkedIn/X/Instagram, set permissions and approval flow
3. **Cross-post and schedule a campaign** — toggle cross-post, channel-specific variants, calendar scheduling
4. **Measure unified performance** — blended Activity view, subscribed weekly report
5. **Final Project** — publish a real cross-channel campaign with calendar screenshot + reflection

---

## 🎥 Live demo

**[Open the dashboard →](https://gistpreview.github.io/?1a95279e93898ff141b9b4696301273b)**

The dashboard shows the adoption chart, clickable feature bars, AI-generated course recommendations, and a one-click "Create in Skilljar" animation that ends with a real, clickable link to the published course.

**On stage (~90s):**

1. Land on dashboard — point at the chart. *"PX shows us where customers are stuck."*
2. Click the red **Socials** bar — recommendation panel populates with the course outline.
3. Click **▸ Create in Skilljar** — log animates for ~8 seconds.
4. Click the final `READY` link — Skilljar opens with real lessons, real quizzes, real final project.

---

## 🧰 Stack

| Layer | Tool |
|---|---|
| Adoption data | Gainsight PX MCP server |
| Reasoning + course design | Claude Sonnet 4.6 |
| Course publishing | Skilljar API (staging) via custom MCP |
| Dashboard | Single-file HTML · Tailwind · Chart.js |
| Hosting | GitHub Gist + gistpreview.github.io |
| Build orchestration | Claude Code with parallel MCP calls |

---

## 🔁 Why this matters

This is the smallest, sharpest demonstration of a workflow customers have been asking for: **observability → recommendation → action → measurement, in one pane of glass.**

- PX shows the gap.
- An agent designs the fix.
- Skilljar ships the fix.
- PX measures whether the fix worked.

The agent in the middle is the new part — and the only piece that wasn't possible before.

---

---

## ⚡ Try it yourself: the Adoption Impact Loop skill

This repo ships an installable Claude Code skill that runs the whole loop end-to-end. Anyone who clones the repo gets it automatically.

```bash
git clone https://github.com/sschumacher-gainsight/px-skilljar-adoption.git
cd px-skilljar-adoption
git checkout spencer
claude
```

Then in Claude Code:

```
run adoption impact loop --demo
```

**What happens:**
1. Detects the lowest-adoption feature set in your Gainsight PX property
2. Pulls support docs via the Community MCP
3. Walks through the feature with a browser MCP (Playwright or Claude_in_Chrome)
4. Designs and publishes a Skilljar course
5. **Records the baseline** in `adoption_history.json` (new)
6. **Seeds a 30-day lift trajectory** in demo mode, or schedules real follow-up PX queries in honest mode (new)
7. **Stamps the Skilljar course** with a "Lifted +X% adoption" green banner + structured label (new)
8. Auto-refreshes the dashboard with the trajectory chart and badge

The full loop runs in ~3 minutes on the live demo. See `.claude/skills/adoption-impact-loop/SKILL.md` for the full spec.

---

*Built for Pulse 2026 · Spencer Schumacher · Gainsight*
