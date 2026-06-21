#!/bin/bash
set -euo pipefail
# Usage: curl -sL https://raw.githubusercontent.com/JakobMelchard/cloudflare-core/main/install.sh | bash

CORE_REPO="JakobMelchard/cloudflare-core"
COREDIR=".core"

if [ -d "$COREDIR" ]; then
  echo "Already installed. Run: curl -sL https://raw.githubusercontent.com/$CORE_REPO/main/update.sh | bash"
  exit 1
fi

if git rev-parse --git-dir &>/dev/null; then
  git submodule add "https://github.com/$CORE_REPO.git" "$COREDIR"
  git submodule update --init "$COREDIR"
else
  git clone --branch main "https://github.com/$CORE_REPO.git" "$COREDIR"
fi

git config core.hooksPath "$COREDIR/hooks/"

for f in .gitignore .gitleaks.toml _exclude \
         release-please-config.json .release-please-manifest.json; do
  [ -f "$f" ] || cp "$COREDIR/$f" "$f"
done

mkdir -p .github/workflows
[ -f .github/workflows/release.yml ] || \
  cp "$COREDIR/.github/workflows/release.yml" .github/workflows/release.yml

cat >> _exclude 2>/dev/null <<'EOF'
/.core
/scripts
EOF

if ! command -v gitleaks &>/dev/null; then
  echo "  ⚠ gitleaks not found — install manually"
fi

echo "✓ installed"
echo "  Update: curl -sL https://raw.githubusercontent.com/$CORE_REPO/main/update.sh | bash"
