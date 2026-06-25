#!/usr/bin/env python3
"""
Seed a realistic demo trajectory for a freshly-published course.

Given a baseline (user count, account count, total active users in property),
generate a sigmoid lift curve at Day 3, 7, 14, 30 and append to adoption_history.json.

Usage:
    seed_demo_trajectory.py \
        --feature-id <id> \
        --feature-name "Socials" \
        --property-key AP-APQZV27FN3T6-2-1 \
        --course-id y7waa42370y \
        --course-title "Socials in EmailMonkey: From Zero to Multi-Channel" \
        --course-url "https://..." \
        --baseline-users 0 \
        --total-active 5061 \
        --accounts 183 \
        --history-path ./adoption_history.json
"""
import argparse, json, math, sys
from datetime import datetime, timedelta, timezone
from pathlib import Path


def sigmoid(x: float) -> float:
    return 1 / (1 + math.exp(-x))


def trajectory(baseline: int, ceiling: int) -> list[tuple[int, int]]:
    """Return [(day, users), ...] for days 0, 3, 7, 14, 30."""
    days = [0, 3, 7, 14, 30]
    # Sigmoid centered around day 10, scaled so day 30 ~85% of ceiling
    points = []
    for d in days:
        if d == 0:
            points.append((d, baseline))
            continue
        # Map day to sigmoid input: -3 at day 1, +3 at day 30
        x = (d - 10) / 4.5
        frac = sigmoid(x)
        users = baseline + int(round(frac * (ceiling - baseline)))
        points.append((d, users))
    return points


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--feature-id", required=True)
    p.add_argument("--feature-name", required=True)
    p.add_argument("--property-key", required=True)
    p.add_argument("--course-id", required=True)
    p.add_argument("--course-title", required=True)
    p.add_argument("--course-url", required=True)
    p.add_argument("--baseline-users", type=int, default=0)
    p.add_argument("--total-active", type=int, required=True,
                   help="Total active users in the PX property (denominator for lift %)")
    p.add_argument("--accounts", type=int, default=0)
    p.add_argument("--ceiling-fraction", type=float, default=0.25,
                   help="Projected ceiling as fraction of total_active (default 0.25 = 25%%)")
    p.add_argument("--history-path", default="./adoption_history.json")
    p.add_argument("--start-date", default=None,
                   help="ISO 8601 baseline date; defaults to now()")
    args = p.parse_args()

    start = (
        datetime.fromisoformat(args.start_date.replace("Z", "+00:00"))
        if args.start_date else datetime.now(timezone.utc)
    )
    ceiling = max(args.baseline_users + 50, int(args.total_active * args.ceiling_fraction))
    points = trajectory(args.baseline_users, ceiling)

    measurements = []
    for day, users in points:
        date = (start + timedelta(days=day)).isoformat().replace("+00:00", "Z")
        # Accounts grow roughly half as fast as users (multi-user per account)
        accounts_frac = (users - args.baseline_users) / max(ceiling - args.baseline_users, 1)
        accounts = int(round(accounts_frac * args.accounts * 0.85))
        note = {
            0: "Baseline at course publish",
            3: "Day 3 follow-up",
            7: "Day 7 follow-up — early adopters engaging",
            14: "Day 14 follow-up — knee of the curve",
            30: "Day 30 follow-up — lift confirmed, badge eligible",
        }.get(day, f"Day {day} follow-up")
        measurements.append({
            "day": day, "date": date, "users": users,
            "accounts": accounts, "note": note,
        })

    final_users = measurements[-1]["users"]
    delta = final_users - args.baseline_users
    pct = round(100.0 * delta / max(args.total_active, 1), 1)
    acct_pct = round(100.0 * measurements[-1]["accounts"] / max(args.accounts, 1), 1)

    entry = {
        "feature_id": args.feature_id,
        "feature_name": args.feature_name,
        "property_key": args.property_key,
        "course_id": args.course_id,
        "course_title": args.course_title,
        "course_url": args.course_url,
        "baseline_date": measurements[0]["date"],
        "baseline_users": args.baseline_users,
        "total_active_users": args.total_active,
        "accounts_in_property": args.accounts,
        "mode": "demo",
        "projected_ceiling": ceiling,
        "measurements": measurements,
        "lift": {
            "users_delta": delta,
            "users_pct_of_active": pct,
            "accounts_pct": acct_pct,
            "days_elapsed": 30,
        },
        "badge_stamped": False,
        "badge_stamp_date": None,
        "badge_text": f"Lifted +{pct}% adoption",
        "skilljar_label_id": None,
    }

    path = Path(args.history_path)
    if path.exists():
        history = json.loads(path.read_text())
    else:
        history = {"$schema_version": "1.0", "courses": []}

    # Replace existing entry for this course_id or append
    courses = [c for c in history.get("courses", []) if c.get("course_id") != args.course_id]
    courses.append(entry)
    history["courses"] = courses

    path.write_text(json.dumps(history, indent=2) + "\n")
    print(json.dumps(entry, indent=2))


if __name__ == "__main__":
    sys.exit(main() or 0)
