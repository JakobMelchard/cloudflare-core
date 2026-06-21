#!/bin/bash
set -euo pipefail
# Usage: curl -sL https://raw.githubusercontent.com/JakobMelchard/cloudflare-core/main/update.sh | bash

COREDIR=".core"

if [ ! -d "$COREDIR" ]; then
  ROOT="$PWD"
  while [ ! -d "$ROOT/$COREDIR" ] && [ "$ROOT" != "/" ]; do ROOT=$(dirname "$ROOT"); done
  [ -d "$ROOT/$COREDIR" ] && cd "$ROOT" || { echo "Not installed." >&2; exit 1; }
fi

cd "$COREDIR"
git fetch origin
OLD=$(git rev-parse HEAD)
NEW=$(git rev-parse @{upstream} 2>/dev/null || git rev-parse origin/main)

[ "$OLD" = "$NEW" ] && echo "Already up to date." && exit 0

echo "→ Updating core..."
git merge --ff-only "@{upstream}" 2>/dev/null || git merge --ff-only origin/main
git log --oneline "$OLD..HEAD"
cd ..
echo "✓ Updated. Commit: git add $COREDIR && git commit -m \"chore: update core\""
