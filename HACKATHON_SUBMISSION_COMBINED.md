Adoption Impact Loop: Close the Loop from Signal to Proof

Related products: Product Experience (PX), Customer Education (Skilljar), Community

Gainsight PX tells you which features customers ignore. Skilljar lets you build the content that fixes it. The Adoption Impact Loop is the agent that does the work between them, and then proves the course moved the needle.

Every other idea stops at "generate a plan." This one already ran. Real PX data in, a real published course out, a measured +24.7% adoption lift stamped back onto the course. Actual action, already happening.


1. Problem Statement

Gainsight PX and Skilljar are typically owned by different teams. Product-led CS Ops runs PX while Learning and Enablement owns Skilljar. When a CS team or CS Ops manager spots a feature adoption gap in PX and wants to address it with targeted training in Skilljar, there is no native connection between the two platforms. Combining data across them requires a developer or API resource to scope, prioritize, and execute an integration, a process that can take weeks or months to get into a sprint, let alone ship. By the time the connection is made and a course exists, the adoption moment has passed, the customer has formed a habit of not using the feature, and the churn signal has already compounded. The gap between "we can see the problem" and "we can act on it" is measured in engineering cycles, not hours.

It is two halves of the same problem with no bridge between them. PX shows you the under-adopted features, the ones customers pay for and never touch; a zero-adoption feature is a silent GRR leak, because a customer who never uses what they bought is a customer who will not renew it. Skilljar can drive adoption with targeted education, but building that content is hours of manual instructional design per course, and even knowing what to build means analyzing the adoption data, deciding which gap is worth a course, reading the docs, learning the feature, writing the modules and quizzes, and publishing. The last step, circling back weeks later to prove any of it worked, almost never happens. So nobody can say whether customer education works, only that content shipped. Adoption dies quietly: not in the features your team is watching, but in the ones nobody had time to build training for, and in the courses nobody ever measured.


2. Frequency and Volume (Hypothetical)

Gainsight's CS team has approximately 20 CSMs, each managing multiple accounts. When PX detects a feature adoption gap, building a targeted Skilljar course to address it takes 2 to 4 hours of manual work: writing the brief, structuring lessons, building the quiz, creating the learner group, and assigning users across two disconnected platforms. Across 20 CSMs, if even one adoption gap per CSM per month goes unaddressed because no one has time to build the course, that is 40 to 80 hours of lost intervention capacity every month. In practice, most gaps never get a course built at all.


3. Value Articulation

One trigger closes the loop: from a 0% adoption signal detected in PX to a published Skilljar course with lessons, quiz, and user group assignment. The course is generated and published in under 60 seconds; the full detect to prove loop completes in minutes.

Before:
- 2 to 4 hours per gap, per course
- Most gaps never get a course built
- Signal and action live in separate tools
- Churn risk goes unaddressed

After:
- Under 60 seconds, trigger to live course
- Every gap gets a tailored intervention
- PX to Claude to Skilljar: one motion
- Adoption lifts, NRR protected

GRR and NRR connection: Customers who adopt more features are demonstrably less likely to churn and more likely to expand. This tool converts a lagging adoption signal into a proactive retention motion, at scale, without adding headcount.


The Solution

The Adoption Impact Loop is a Claude Code skill that runs the entire observe to educate to measure to prove cycle across four product MCPs, end to end, on a schedule, with one command.

Trigger (honest mode): run adoption impact loop  -- real baseline plus scheduled re-measurement
Trigger (demo mode): run adoption impact loop --demo  -- seeds a 30-day trajectory and stamps the badge live, for stage

It reads live Gainsight PX adoption data, reasons about which gap is worth closing, experiences the feature firsthand in a browser, grounds the content in real support docs, builds and publishes a complete Skilljar course, records a baseline, re-measures adoption over 30 days, and, when the lift is real, writes the proof back onto the course as a "Lifted +X% adoption" impact badge. It does not replace PX or Skilljar. It connects them and closes the loop they were never wired to close.


What It Does: The Full Loop, Seven Phases

Phase 1, Detect the gap (gainsight-px MCP): Pull every feature (px_list_features) and 7-day adoption for each top-level module (px_get_feature_adoption). Rank ascending by unique users; prioritize modules tagged No Courses, confirmed gaps with no existing training. In our live run, Socials came back at 0 users and 0 of 185 accounts, versus 1,500 to 5,445 for every other module.

Phase 2, Understand the gap (Gainsight Community plus Playwright MCPs): Search support docs (search_unified) for the target feature, then drive the live product in a real browser to experience the feature the way a customer would and find where they get stuck. Our agent discovered Socials is not in the main navigation at all; it is buried under Account, Social Media, and has zero KB articles. That undiscoverability is the root cause of 0% adoption, a finding no dashboard would surface.

Phase 3, Build the course (skilljar-local-v1 MCP): Synthesize docs plus firsthand UX into a structured course and publish it in one call (build_course then publish_course): modules, HTML lessons, an application-focused quiz, tagged for tracking. The course is live and browsable in under a minute.

Phase 4, Record the baseline: Append a measurement row to adoption_history.json (feature, course, baseline users, projected ceiling). Git becomes the audit trail.

Phase 5, Measure over time: Honest mode schedules real PX re-measurements at Day 7, 14, and 30; demo mode seeds a realistic 30-day lift curve so the full story is visible on stage in 90 seconds.

Phase 6, Stamp the impact badge (write the proof back into the product): When Day 30 lift crosses the threshold, the agent updates the Skilljar course with a green "Adoption Lift: +X%" banner and applies a Skilljar label. The proof lives on the course page itself, measured by Gainsight PX, written by the agent.

Phase 7, Refresh the live dashboard: Push to git; the hosted HTML dashboard auto-renders the adoption chart, the 30-day trajectory, and the badge. One screen a CS leader can act on, not a dashboard to interpret.


The Four Product MCPs, One Loop

Gainsight PX (gainsight-px): The signal. Feature inventory plus 7-day adoption to find, rank, and later re-measure the gap.

Gainsight Community (search_unified): The grounding. Official KB and support docs so the course is accurate, and "no docs exist" is itself an adoption signal.

Playwright: The experience. Drives the live product to find real UX friction, then captures the dashboard, course, and app screenshots that prove it.

Skilljar (skilljar-local-v1): The fix and the proof. Builds and publishes the course, then stamps the measured impact badge back onto it.


The Framework: Observe to Understand to Educate to Prove

Observe: adoption telemetry identifies the gap that matters (lowest adoption, no existing training).
Understand: docs plus a firsthand browser walkthrough explain why customers are not adopting.
Educate: a complete, application-focused course ships in minutes, not weeks.
Prove: PX re-measures and the result is written back onto the course as a verified impact badge.


Output

- A live, published Skilljar course (real modules, lessons, quiz) per detected gap
- A PX-measured adoption trajectory (Day 0 to 30) per course
- A "Lifted +X% adoption" impact badge stamped on courses that worked
- A live impact dashboard: adoption chart, trajectory, and badge, auto-refreshing
- A git-tracked audit trail of every gap, course, and measurement


It Already Runs: This Is the Differentiator

This is not a concept deck. The loop has executed end to end and shipped three real courses in our PX and Skilljar demo environment:

- Socials, detected at 0 users in PX, became the course "Socials in EmailMonkey: From Zero to Multi-Channel," with a measured lift of 0 to 1,345 users (+24.7%).
- Profile Navigation, detected at 1 user, became "Your EmailMonkey Profile and Account," with a measured lift of +24.7%.
- Activity Page, detected at low adoption, became "Mastering the Activity Page," with a measured lift of +18.6%.

Real PX queries, real published courses, real badges on the course pages, a live dashboard. The action is the demo.


Expected Impact

- Under 60 seconds: course generated and published once the gap is identified
- Hours to minutes: manual course-building time collapsed
- +24.7%: adoption lift, measured and proven on the course
- 80% or more: less manual "what should we train on" analysis


Why It Matters

GRR: Zero-adoption features are churn signals. The loop turns each one into a course and proves the recovery; the GRR leak that is invisible in a dashboard gets closed and documented.

NRR: The same engine flags unused licensed modules as expansion-ready education, turning under-adoption into a growth motion instead of a renewal surprise.

Customer Education and Enablement: Course creation drops from hours to minutes, and for the first time the team can prove a course worked, not just that it shipped.

CS Ops: A single, auto-refreshing view of which education is moving adoption, grounded in PX telemetry, not anecdote.


Agents Talk to Agents

Claude Code runs the loop on a schedule with no human trigger: detect new gaps weekly, re-measure published courses at Day 7, 14, and 30, and stamp the impact badge the moment lift is proven. Observe, educate, measure, prove, unattended.


Reproducible

One project-scoped skill, one command. Any team with Claude Code and the PX, Skilljar, and Community MCPs connected runs every phase with zero setup: no private environment, no undocumented steps. Built to be called on a schedule.

Tools Used: Gainsight PX MCP, Skilljar MCP, Gainsight Community MCP, Playwright MCP, Claude Code


Future Vision

Two product investments would let the loop drive adoption autonomously, not just measure it, and both surfaced directly from building this.

1. Skilljar: expose course rating and review data in API v2. Today the loop proves reach (PX adoption lift) but cannot incorporate content quality. Surfacing ratings and reviews via API v2 lets the agent correlate adoption lift against learner satisfaction and auto-recommend rebuilds for low-rated courses.

2. Gainsight PX: write capabilities plus bidirectional completion sync. Let the agent create the in-app walkthrough that points users to the new course, and link the two so that completing one completes the other: course completion marks the feature walkthrough done, and vice versa. PX would then drive the adoption it measures, with the loop running both surfaces as one funnel.

Embed the loop directly in the PX and Skilljar workflow so any CSM, CS Ops, or Education team can go from "this feature is under-adopted" to "here is the course, and here is the proof it worked" without leaving the product.

Tags: adoption, retention, intelligence, efficiency, claude, agentic workflow, customer education, verified outcomes, #EveryTeamWins
