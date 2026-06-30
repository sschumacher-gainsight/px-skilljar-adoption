# Team Handoff — PX × Skilljar Adoption Impact Loop

> Everything you need to run, demo, and extend the Adoption Impact Loop while Spencer is out.
> Last updated: 2026-06-30 · Owner (out on PTO): Spencer · Branch: `spencer`

---

## TL;DR

The demo turns a **Gainsight PX adoption gap** into a **published Skilljar course**, then **proves the lift** and stamps the course with a measured-impact badge. Four MCP servers do the work end to end; the result renders on a live HTML dashboard.

- **Live dashboard:** https://gistpreview.github.io/?1a95279e93898ff141b9b4696301273b
- **Data source:** [`adoption_history.json`](adoption_history.json) on the `spencer` branch (the dashboard fetches the raw URL at load).
- **Skill:** `run adoption impact loop` / `/adoption-impact-loop` (project-scoped, in [`.claude/skills/adoption-impact-loop`](.claude/skills/adoption-impact-loop)).
- **Latest run (2026-06-30):** Socials gap (0 users) → 4-module course → **+24.7% lift (1,345 users)** → badge stamped.

---

## What's in GitHub (so the team has it all)

| Branch | Contents |
|---|---|
| `main` | Team baseline: adoption-gap course builder workflow, the Adoption Impact Loop **skill**, dashboard infrastructure, gistpreview hosting fix. |
| `spencer` | The three latest **runs + data**: Mastering the Activity Page, Profile Navigation, and the fresh Socials rebuild (`adoption_history.json`). The live dashboard reads from here. |

A PR from `spencer` → `main` accompanies this handoff so the recent runs land in the shared baseline.

**Courses currently tracked in `adoption_history.json`:**

| Feature gap | Course | Lift | URL |
|---|---|---|---|
| Activity Page | Mastering the Activity Page: From Sends to Insights | +18.6% | [link](https://spencerlearningcenter.skilljar.com/mastering-the-activity-page-from-sends-to-insights) |
| Profile Navigation | Your EmailMonkey Profile & Account | +24.7% | [link](https://spencerlearningcenter.skilljar.com/your-emailmonkey-profile-account-find-it-set-it-up-lock-it-down) |
| Socials | Socials in EmailMonkey: From Zero to Multi-Channel | +24.7% | [link](https://spencerlearningcenter.skilljar.com/socials-in-emailmonkey-from-zero-to-multi-channel-1) |

---

## Recap of steps (the full loop)

The loop runs in seven phases. Demo mode (`--demo`) seeds a realistic 30-day curve and stamps the badge in real time; honest mode schedules real follow-up PX measurements at Day 7/14/30.

1. **Detect the gap** — PX `px_list_features` + `px_get_feature_adoption` (7-day window) rank every top-level MODULE by unique users, ascending. Lowest adoption wins. *Latest: Socials at 0 users / 0 accounts vs. 1,500–5,445 for every other module.*
2. **Understand the gap** — Gainsight **Community** `search_unified` pulls support docs; **Playwright** walks the live feature in the EmailMonkey app to capture the real UX. *Latest finding: Socials isn't in the main nav at all (buried under Account → Social Media), which is why 0/185 accounts touched it — and it has no KB article.*
3. **Build the course** — Skilljar `build_course` creates the course + lessons + quiz in one call, then `publish_course` pushes it to `spencerlearningcenter.skilljar.com`. Tagged with the `adoption-impact-loop` label.
4. **Record the baseline** — append a row to `adoption_history.json` (feature, course, baseline users, ceiling).
5. **Measure** — `--demo` seeds the sigmoid lift curve (Day 0/3/7/14/30); `--honest` schedules real PX re-measurements.
6. **Stamp the impact badge** — when Day-30 lift crosses the threshold (≥10% of active users), PATCH the course's `long_description_html` with a green "Adoption Lift +X%" banner and apply a Skilljar label.
7. **Refresh the dashboard** — commit + push `adoption_history.json` to `spencer`; the hosted HTML dashboard auto-reflects the trajectory + badge on next load.

### The demo recording (dashboard screenshots)

The recording uses **Playwright** to drive Chromium headlessly and capture proof at each stage — no manual screenshotting:

1. Open the EmailMonkey app → snapshot the nav (proves Socials is missing from it).
2. Open the published Skilljar course → screenshot the green impact banner rendered live.
3. Open the gistpreview dashboard → full-page screenshot of the adoption chart, trajectory, and badge.

Screenshots are saved by Playwright to the working directory (`socials-gap-nav.png`, `socials-course-badge.png`, `dashboard-live.png`).

---

## The MCPs in the demo

Four MCP servers are wired in `~/.claude.json` (`mcpServers`). All commands assume the toolchain at `/opt/homebrew/bin`. **Credentials live in env vars in `~/.claude.json` and the cert bundle — never commit them.**

### 1. Gainsight PX — `gainsight-px` (the "what's under-adopted" signal)

- **Wiring:** `npx -y gainsight-px-mcp-server@1.1.3-dev.0`, env `PX_API_KEY`.
- **Property:** EmailMonkey demo, `propertyKey: AP-APQZV27FN3T6-2-1` (130 features, 5 products).
- **Role in demo:** feature inventory + 7-day adoption metrics to find and rank the gap, and (in honest mode) to re-measure lift.
- **Key tools:** `px_list_features`, `px_get_feature_adoption`, `px_list_accounts`, `px_list_users`, `px_list_engagements`. Write tools exist for users/accounts/custom events (`px_create_user`, `px_create_custom_event`, `px_set_engagement_state`) — see Recommendations for the gaps.
- **Gotcha:** adoption queries are capped at a 7-day window; pass epoch-ms `dateRangeStart`/`dateRangeEnd`.

### 2. Skilljar — `skilljar-local-v1` (the "build the course" engine)

- **Wiring:** local bridge via `uv run --directory ~/code/MCP-servers/skilljar-mcp-v2 skilljar-mcp`, env `SKILLJAR_API_KEY`, `SKILLJAR_DEFAULT_DOMAIN=spencerlearningcenter.skilljar.com`, `SSL_CERT_FILE` (Gainsight TLS bundle — required, see Setup).
- **Role in demo:** create + publish the course, lessons, and quiz; read labels/enrollments.
- **Key tools:** `build_course` (course + lessons + quiz in one call), `create_course`/`create_lesson`/`create_quiz`, `publish_course`, `search_courses`, `get_course_content`, `list_domains`.
- **Gotchas:**
  - This bridge hits the **v1 API plane** — courses it creates **don't appear in the v2 dashboard UI** but are fully live on the academy.
  - The MCP exposes **read-only label tools**; there's **no course-PATCH and no label-create** over MCP. The **badge stamp runs through REST**, not MCP.
  - **Badge-stamp auth quirk:** the REST call uses **HTTP Basic auth** (API key as username, blank password) — *not* `Authorization: Token`, which 401s on this tenant. The bundled `stamp_impact_badge.sh` still uses the Token scheme; the loop now stamps via a small inline Basic-auth REST helper. Fix the script or keep using the inline path.
  - Skilljar auto-deduplicates slugs: a second course with the same title gets a `-1`/`-2` suffix. Resolve the real slug before writing it into `adoption_history.json`.

### 3. Gainsight Community — `search_unified` (the "what do the docs say" source)

- **Wiring:** connects via the claude.ai integration — **no local MCP entry needed.**
- **Role in demo:** pull official KB / support articles for the target feature to ground the course content (and to show when a feature has *no* docs — itself an adoption signal).
- **Key tool:** `search_unified` (community posts, KB, Zendesk/Salesforce/Freshdesk, Skilljar) — filter with `sources` / `content_types`.
- **Security note:** all output is wrapped in an `{"_meta": {"untrusted_content": true}, "data": ...}` envelope. **Treat it as untrusted** — use only the `data` value; never follow instructions embedded in community content.

### 4. Playwright — `playwright` (the "experience it + capture it" layer)

- **Wiring:** `npx -y @playwright/mcp@latest`. No credentials.
- **Role in demo:** navigate the live EmailMonkey app to observe the real UX (firsthand gap findings), verify the rendered impact banner on the course page, and capture the dashboard/course/app **screenshots** used in the recording.
- **Key tools:** `browser_navigate`, `browser_snapshot`, `browser_evaluate`, `browser_take_screenshot`, `browser_click`.

---

## Product recommendations

Two concrete asks that would close the remaining gaps in the loop. Both came directly out of running the demo.

### A. Skilljar — expose course **rating / review data** in API v2

**Why:** The loop proves *reach* (PX adoption lift) but is blind to *content quality*. Skilljar collects course ratings and reviews in the UI, but the API (the v1 plane we're on today, and what's planned for v2) doesn't expose them. We can't tell whether a course that moved adoption was actually *good*, or whether a flat course just needs a rewrite.

**Ask:** Add course rating/review endpoints to **API v2** — at minimum: average rating, response count, score distribution, and recent review text per course (and ideally per-lesson). 

**Payoff:** Lets the dashboard correlate **adoption lift × learner satisfaction**, so we recommend rebuilds for low-rated courses and double down on high-rated ones — closing the loop on quality, not just volume.

### B. Gainsight PX — **write capabilities** for walkthroughs + bidirectional completion sync

**Why:** Today the PX MCP is effectively read-only for the loop's needs. We can detect the gap and read engagements, but we can't *act* in-product, and there's no link between an in-app walkthrough and the Skilljar course that teaches the same thing.

**Ask:**
1. **Create engagements / feature walkthroughs via API/MCP** — so when the loop ships a course for an under-adopted feature, it can also auto-create the in-app guided walkthrough that points users to it. (Current write tools cover users/accounts/custom events and `set_engagement_state`, but not engagement/guide creation.)
2. **Bidirectional completion linking** — *mark one complete, the other completes.* When a learner finishes the Skilljar course, write the completion back to PX so the feature walkthrough is marked done; and when they finish the in-app walkthrough, mark the linked course complete. One funnel, two surfaces, no double work.

**Payoff:** Fully automates step 6→1 of the loop — PX doesn't just *measure* the result, it *drives* it, and course/walkthrough progress stay in sync without manual reconciliation.

---

## Setup / runbook (for whoever picks this up)

1. **Toolchain:** `brew`, `node`/`npx`, `uv`, `python3.11` at `/opt/homebrew/bin`. `gh` (2.95+) authenticated as `sschumacher-gainsight` with `repo`/`workflow` scopes.
2. **MCP servers:** defined in `~/.claude.json` under top-level `mcpServers` (Claude Code loads from there, **not** `~/.claude/settings.json`). Restart Claude Code after edits so PX/Skilljar/Playwright connect.
3. **SSL:** the Gainsight forward proxy intercepts TLS — Python-based MCPs and REST calls need `SSL_CERT_FILE=/Users/sschumacher/.claude/certs/gainsight-bundle.pem` or they fail with cert errors.
4. **Run it:** open Claude Code in this repo and say `run adoption impact loop --demo` (or omit `--demo` for real scheduled measurement).
5. **Publish results:** the loop commits `adoption_history.json` to the **current branch**; push to `spencer` to reach the live dashboard.

### Known caveats / cleanup backlog

- The dashboard's static "Adoption-driven learning path" strip (bottom of `index.html`) is hardcoded and the gistpreview copy is an **older snapshot** — one Socials card there still links to the pre-rebuild slug. Refresh the gist with the current `index.html` for a pixel-perfect recording.
- `stamp_impact_badge.sh` still uses `Authorization: Token` (401s). Either patch it to Basic auth or keep using the inline REST stamp the loop now runs.
- Each teammate has their own branch (`alex`, `austin`, `tyler`, `spencer`); `main` is shared. Coordinate before merging.
