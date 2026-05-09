#!/usr/bin/env bash
# build.sh — NetHunter kernel build wrapper for SM-T220
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILDER="${HOME}/nethunter-sm-t220/kali-nethunter-kernel-builder"
NDK_BIN="${HOME}/android-ndk-r27c/toolchains/llvm/prebuilt/linux-x86_64/bin"
KERNEL_SOURCE="${HOME}/nethunter-sm-t220/kernel-source"

echo "=== NetHunter Kernel Builder — SM-T220 (gta7litewifi) ==="

[[ -d "${BUILDER}" ]] || { echo "ERROR: Clone NetHunter kernel builder to ${BUILDER}"; exit 1; }
[[ -d "${NDK_BIN}" ]] || { echo "ERROR: Android NDK r27c not found at ${NDK_BIN}"; exit 1; }
[[ -d "${KERNEL_SOURCE}" ]] || { echo "ERROR: Kernel source not found at ${KERNEL_SOURCE}"; exit 1; }

export PATH="${NDK_BIN}:${PATH}"
export CROSS_COMPILE="aarch64-linux-gnu-"
export ARCH="arm64"
export CC="clang"

echo "[1/4] Fixing Samsung OSRC line endings..."
find "${KERNEL_SOURCE}" -name "Kconfig" -exec dos2unix {} \; 2>/dev/null || true

echo "[2/4] Creating DEFEX placeholder certificate..."
mkdir -p "${KERNEL_SOURCE}/security/samsung/defex_lsm/cert"
touch "${KERNEL_SOURCE}/security/samsung/defex_lsm/cert/pubkey_eng.der"

echo "[3/4] Copying local.config to builder..."
cp "${SCRIPT_DIR}/configs/local.config" "${BUILDER}/local.config"

echo "[4/4] Starting NetHunter kernel builder..."
cd "${BUILDER}" && bash build.sh
