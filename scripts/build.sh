#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

"${ROOT_DIR}/scripts/preflight.sh"

echo "[build] Running: colcon build --symlink-install $*"
colcon build --symlink-install "$@"
