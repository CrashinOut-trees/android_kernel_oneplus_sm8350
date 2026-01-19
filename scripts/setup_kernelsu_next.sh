#!/usr/bin/env bash
set -euo pipefail

REPO_URL=${KERNELSU_NEXT_REPO_URL:-"https://github.com/pershoot/KernelSU-Next"}
DEST_DIR=${KERNELSU_NEXT_DIR:-"KernelSU-Next"}

if [[ -d "$DEST_DIR" ]]; then
  echo "KernelSU-Next already exists at $DEST_DIR" >&2
  exit 0
fi

echo "Cloning KernelSU-Next from $REPO_URL into $DEST_DIR..."

git clone --depth=1 "$REPO_URL" "$DEST_DIR"

if [[ -x "$DEST_DIR/kernel/setup.sh" ]]; then
  echo "Running KernelSU-Next setup script..."
  (cd "$DEST_DIR" && bash kernel/setup.sh)
else
  cat <<'NOTE'
KernelSU-Next was cloned, but no setup script was found at kernel/setup.sh.
Please consult the upstream instructions for any additional integration steps.
NOTE
fi
