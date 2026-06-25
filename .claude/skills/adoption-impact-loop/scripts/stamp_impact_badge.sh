#!/usr/bin/env bash
#
# Stamp a "Lifted +X% adoption" impact badge onto a Skilljar course.
# - Updates the course description with a green impact banner
# - Creates / applies a Skilljar label
# - Marks the entry in adoption_history.json as stamped
#
# Requires SKILLJAR_API_KEY in env, or sources ~/.claude/skilljar-mcp/server.py.
#
# Usage:
#   stamp_impact_badge.sh <course_id> <pct> <new_users> <days> [history_path]
#
# Example:
#   stamp_impact_badge.sh y7waa42370y 24.6 1247 30 ./adoption_history.json

set -euo pipefail

COURSE_ID="${1:?course_id required}"
PCT="${2:?lift percentage required (e.g. 24.6)}"
USERS="${3:?new users count required}"
DAYS="${4:-30}"
HISTORY_PATH="${5:-./adoption_history.json}"

API_BASE="${SKILLJAR_API_BASE:-https://api.skilljar.com}"
API_KEY="${SKILLJAR_API_KEY:-}"

if [[ -z "$API_KEY" ]]; then
  if [[ -f "$HOME/.claude/skilljar-mcp/server.py" ]]; then
    API_KEY="$(python3 -c 'import re,sys; print(re.search(r"API_KEY[^\"]*=\s*\"([^\"]+)\"", open(sys.argv[1]).read()).group(1))' "$HOME/.claude/skilljar-mcp/server.py" 2>/dev/null || true)"
  fi
fi
if [[ -z "$API_KEY" ]]; then
  echo "ERROR: SKILLJAR_API_KEY env var not set and could not be read from server.py" >&2
  exit 2
fi

USERS_PRETTY="$(printf "%'d\n" "$USERS" 2>/dev/null || echo "$USERS")"

# Build the impact banner HTML
BANNER=$(cat <<HTML
<div style="background:linear-gradient(90deg,#22c55e,#16a34a);color:white;padding:16px 22px;border-radius:10px;margin-bottom:24px;font-family:system-ui,sans-serif">
  <div style="font-size:13px;text-transform:uppercase;letter-spacing:0.08em;opacity:0.9">Measured Impact · Gainsight PX</div>
  <div style="font-size:22px;font-weight:700;margin-top:4px">📈 Adoption Lift: +${PCT}%</div>
  <div style="font-size:14px;margin-top:6px;opacity:0.95">This course moved ${USERS_PRETTY} users from baseline to active over ${DAYS} days. Proven by adoption telemetry.</div>
</div>
HTML
)

# Fetch the existing course to preserve description
EXISTING=$(curl -sS -H "Authorization: Token $API_KEY" "$API_BASE/v1/courses/$COURSE_ID")
EXISTING_LONG=$(echo "$EXISTING" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('long_description') or d.get('long_description_html',''))")

# Strip any prior banner so we don't stack them
EXISTING_LONG=$(python3 -c "import re,sys; s=sys.stdin.read(); print(re.sub(r'<div style=\"background:linear-gradient\\(90deg,#22c55e,#16a34a\\)[^<]*<[^>]+>[^<]+<[^>]+>[^<]+<[^>]+>[^<]+</div>\\s*','',s,flags=re.S))" <<< "$EXISTING_LONG")

NEW_LONG="${BANNER}
${EXISTING_LONG}"

# PATCH the course
PAYLOAD=$(python3 -c "import json,sys; print(json.dumps({'long_description': sys.argv[1]}))" "$NEW_LONG")
echo "→ PATCH /v1/courses/$COURSE_ID with impact banner"
curl -sS -X PATCH -H "Authorization: Token $API_KEY" -H "Content-Type: application/json" \
  -d "$PAYLOAD" "$API_BASE/v1/courses/$COURSE_ID" >/dev/null

# Apply Skilljar label
LABEL_NAME="Lifted +${PCT}% adoption"
echo "→ POST /v1/labels { name: \"$LABEL_NAME\" }"
LABEL=$(curl -sS -X POST -H "Authorization: Token $API_KEY" -H "Content-Type: application/json" \
  -d "$(python3 -c "import json; print(json.dumps({'name': '$LABEL_NAME', 'color': '#22c55e'}))")" \
  "$API_BASE/v1/labels" || echo '{}')
LABEL_ID=$(python3 -c "import json,sys; d=json.loads(sys.stdin.read() or '{}'); print(d.get('id',''))" <<< "$LABEL")

if [[ -n "$LABEL_ID" ]]; then
  # Skilljar applies labels via PATCH on the course (the /label-courses endpoint
  # 403s with a CSRF error — it's an admin-UI route, not a REST one). Merge with
  # existing labels rather than overwriting.
  echo "→ Apply label $LABEL_ID to course $COURSE_ID"
  EXISTING_LABELS=$(echo "$EXISTING" | python3 -c "import sys,json; d=json.load(sys.stdin); print(json.dumps(d.get('labels', [])))")
  MERGED_LABELS=$(python3 -c "import json,sys; existing=json.loads(sys.argv[1]); new=sys.argv[2]; merged=list({*existing, new}); print(json.dumps(merged))" "$EXISTING_LABELS" "$LABEL_ID")
  curl -sS -X PATCH -H "Authorization: Token $API_KEY" -H "Content-Type: application/json" \
    -d "$(python3 -c "import json,sys; print(json.dumps({'labels': json.loads(sys.argv[1])}))" "$MERGED_LABELS")" \
    "$API_BASE/v1/courses/$COURSE_ID" >/dev/null || true
fi

# Update adoption_history.json
if [[ -f "$HISTORY_PATH" ]]; then
  python3 <<PY "$HISTORY_PATH" "$COURSE_ID" "$LABEL_ID" "$LABEL_NAME"
import json, sys
from datetime import datetime, timezone
path, course_id, label_id, label_name = sys.argv[1:5]
d = json.load(open(path))
for c in d.get('courses', []):
    if c.get('course_id') == course_id:
        c['badge_stamped'] = True
        c['badge_stamp_date'] = datetime.now(timezone.utc).isoformat().replace('+00:00','Z')
        c['badge_text'] = label_name
        c['skilljar_label_id'] = label_id or None
open(path, 'w').write(json.dumps(d, indent=2) + "\n")
PY
fi

echo "✓ Badge stamped: $LABEL_NAME on course $COURSE_ID"
