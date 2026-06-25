#!/bin/bash
set -euo pipefail
# Usage: curl -sL https://raw.githubusercontent.com/JakobMelchard/cloudflare-core/main/install.sh | bash
# Or:    bash install.sh [dir]

REPO="https://github.com/JakobMelchard/cloudflare-core.git"
DIR="${1:-.}"
mkdir -p "$DIR"
cd "$DIR"

# Case A — already has .core submodule
if [ -f .gitmodules ] && grep -q '\.core' .gitmodules 2>/dev/null; then
  git submodule update --init --remote .core 2>/dev/null || true
  git config core.hooksPath .core/hooks/
  echo "✓ cloudflare-core updated"
  exit 0
fi

# Case B — git repo without .core
if [ -d .git ]; then
  git submodule add "$REPO" .core
  git submodule update --init .core
  git config core.hooksPath .core/hooks/
  echo "✓ cloudflare-core installed as submodule"
  exit 0
fi

# Case C — fresh directory
TMP=$(mktemp -d)
git clone --depth 1 "$REPO" "$TMP"
tar cf - --exclude=.git -C "$TMP" . | tar xf -
rm -rf "$TMP"
git init
git config core.hooksPath hooks/
echo "✓ cloudflare-core installed in $DIR"
