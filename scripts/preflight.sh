#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

echo "[preflight] Workspace: ${ROOT_DIR}"

if ! command -v colcon >/dev/null 2>&1; then
  echo "[preflight] ERROR: 'colcon' is not installed or not on PATH."
  exit 1
fi

if [[ -z "${ROS_DISTRO:-}" ]]; then
  if [[ -f /opt/ros/humble/setup.bash ]]; then
    # shellcheck disable=SC1091
    source /opt/ros/humble/setup.bash
    echo "[preflight] ROS_DISTRO not set; sourced /opt/ros/humble/setup.bash"
  else
    echo "[preflight] ERROR: ROS environment not loaded."
    echo "[preflight] Run: source /opt/ros/<distro>/setup.bash"
    exit 1
  fi
fi

required_packages=(
  libgz-msgs9-dev
  libgz-transport12-dev
  libgz-sim7-dev
)

missing_packages=()
for pkg in "${required_packages[@]}"; do
  if ! dpkg-query -W -f='${Status}' "${pkg}" 2>/dev/null | grep -q "install ok installed"; then
    missing_packages+=("${pkg}")
  fi
done

if ((${#missing_packages[@]} > 0)); then
  echo "[preflight] ERROR: Missing apt packages:"
  printf '  - %s\n' "${missing_packages[@]}"
  echo "[preflight] Install with:"
  echo "  sudo apt-get update && sudo apt-get install -y ${missing_packages[*]}"
  exit 1
fi

broken_symlinks="$(find -L src -type l 2>/dev/null || true)"
if [[ -n "${broken_symlinks}" ]]; then
  echo "[preflight] ERROR: Broken symlinks found in src/:"
  echo "${broken_symlinks}" | sed -n '1,25p'
  link_count="$(echo "${broken_symlinks}" | wc -l | tr -d ' ')"
  if ((link_count > 25)); then
    echo "[preflight] ... and $((link_count - 25)) more"
  fi
  exit 1
fi

if [[ -d build || -d install || -d log ]]; then
  echo "[preflight] NOTE: build/install/log exist. If sources were moved, clean with:"
  echo "  rm -rf build install log"
fi

echo "[preflight] OK"
