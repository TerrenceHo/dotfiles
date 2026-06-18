#!/usr/bin/env bash
set -euo pipefail

# system-install.sh — install system-level configs from dotfiles repo
#
# Usage:
#   sudo ./system/install.sh          # install, prompting on changes
#   sudo ./system/install.sh --diff   # dry run, only show diffs
#   sudo ./system/install.sh --force  # overwrite without prompting
#
# Place system configs under system/root/ mirroring the filesystem:
#   system/root/etc/udev/rules.d/50-zsa.rules
#   system/root/etc/X11/xorg.conf.d/10-nvidia.conf
#   system/root/etc/lightdm/lightdm.conf
#
# They'll be copied to /etc/udev/rules.d/50-zsa.rules, etc.

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

changed=0
installed=0
skipped=0

install_file() {
    local src="$1"
    local dest="/${src#"${SOURCE_ROOT}/"}"
    local dest_dir
    dest_dir="$(dirname "$dest")"

    # new file
    if [[ ! -e "$dest" ]]; then
        if [[ "$MODE" == "--diff" ]]; then
            echo -e "\033[32m[new]\033[0m $dest"
            changed=$((changed + 1))
            return
        fi
        echo -e "\033[32m[installing]\033[0m $dest"
        mkdir -p "$dest_dir"
        cp "$src" "$dest"
        chown root:root "$dest"
        chmod 644 "$dest"
        installed=$((installed + 1))
        return
    fi

    # unchanged
    if diff -q "$src" "$dest" &>/dev/null; then
        skipped=$((skipped + 1))
        return
    fi

    # changed
    changed=$((changed + 1))
    echo -e "\033[33m[changed]\033[0m $dest"
    diff --color=auto -u "$dest" "$src" || true

    if [[ "$MODE" == "--diff" ]]; then
        return
    fi

    if [[ "$MODE" != "--force" ]]; then
        read -rp "  overwrite? [y/N] " answer </dev/tty
        if [[ ! "$answer" =~ ^[Yy]$ ]]; then
            echo "  skipped."
            changed=$((changed - 1))
            skipped=$((skipped + 1))
            return
        fi
    fi

    cp "$src" "$dest"
    chown root:root "$dest"
    chmod 644 "$dest"
    installed=$((installed + 1))
}

# --- install -----------------------------------------------------------------

while IFS= read -r -d '' file; do
    install_file "$file"
done < <(find "$SOURCE_ROOT" -type f -print0 | sort -z)

# --- post-install hooks ------------------------------------------------------

reload_udev=false
reload_sysctl=false
reload_xorg=false

for file in $(find "$SOURCE_ROOT" -type f 2>/dev/null); do
    dest="/${file#"${SOURCE_ROOT}/"}"
    case "$dest" in
    /etc/udev/rules.d/*) reload_udev=true ;;
    /etc/sysctl.d/*) reload_sysctl=true ;;
    /etc/X11/*) reload_xorg=true ;;
    esac
done

if [[ "$MODE" != "--diff" ]]; then
    if $reload_udev; then
        echo -e "\n\033[36m[hook]\033[0m reloading udev rules..."
        udevadm control --reload-rules && udevadm trigger
    fi
    if $reload_sysctl; then
        echo -e "\033[36m[hook]\033[0m reloading sysctl..."
        sysctl --system &>/dev/null
    fi
    if $reload_xorg; then
        echo -e "\033[36m[hook]\033[0m xorg configs updated (takes effect on next login)"
    fi
fi

# --- summary -----------------------------------------------------------------

echo ""
if [[ "$MODE" == "--diff" ]]; then
    echo "dry run: ${changed} file(s) would change, ${skipped} unchanged"
else
    echo "done: ${installed} installed, ${changed} changed, ${skipped} unchanged"
fi
