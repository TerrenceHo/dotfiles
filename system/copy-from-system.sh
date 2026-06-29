#!/usr/bin/env bash
set -euo pipefail

# copy-from-system.sh — pull live system configs back into the dotfiles repo
#
# Usage:
#   sudo ./system/copy-from-system.sh          # copy, prompting on changes
#   sudo ./system/copy-from-system.sh --diff   # dry run, only show diffs
#   sudo ./system/copy-from-system.sh --force  # overwrite without prompting
#
# Mirrors system/install.sh but in reverse: for every file tracked under
# system/root/ it reads the live version from / and copies it back.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_ROOT="${SCRIPT_DIR}/root"
MODE="${1:-}"

# --- preflight ---------------------------------------------------------------

if [[ $EUID -ne 0 ]]; then
    echo "error: must be run as root (use sudo)" >&2
    exit 1
fi

if [[ ! -d "$SOURCE_ROOT" ]]; then
    echo "error: ${SOURCE_ROOT} not found" >&2
    echo "Place system configs under system/root/ mirroring the filesystem." >&2
    exit 1
fi

# --- helpers -----------------------------------------------------------------

copied=0
declined=0
skipped=0

copy_from_system() {
    local tracked="$1"
    local live="/${tracked#"${SOURCE_ROOT}/"}"

    # live file missing
    if [[ ! -e "$live" ]]; then
        echo -e "\033[31m[missing]\033[0m $live (not present on system, skipping)"
        skipped=$((skipped + 1))
        return
    fi

    # unchanged
    if diff -q "$live" "$tracked" &>/dev/null; then
        skipped=$((skipped + 1))
        return
    fi

    # changed
    echo -e "\033[33m[changed]\033[0m $live"
    diff --color=auto -u "$tracked" "$live" || true

    if [[ "$MODE" == "--diff" ]]; then
        declined=$((declined + 1))
        return
    fi

    if [[ "$MODE" != "--force" ]]; then
        read -rp "  copy into dotfiles? [y/N] " answer </dev/tty
        if [[ ! "$answer" =~ ^[Yy]$ ]]; then
            echo "  skipped."
            declined=$((declined + 1))
            return
        fi
    fi

    cp "$live" "$tracked"
    copied=$((copied + 1))
}

# --- copy --------------------------------------------------------------------

while IFS= read -r -d '' file; do
    copy_from_system "$file"
done < <(find "$SOURCE_ROOT" -type f -print0 | sort -z)

# --- summary -----------------------------------------------------------------

echo ""
if [[ "$MODE" == "--diff" ]]; then
    echo "dry run: ${declined} file(s) differ, ${skipped} unchanged or missing"
else
    echo "done: ${copied} copied, ${declined} declined, ${skipped} unchanged or missing"
fi
