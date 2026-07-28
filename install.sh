#!/bin/bash
stow -t ~ common

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    stow -t ~ wayland
else
    stow -t ~ xorg
fi

if lspci | grep -qi nvidia; then
    stow -t ~ nvidia-gpu
elif lspci | grep -qi amd.*vga\|radeon; then
    stow -t ~ amd-gpu
fi

PROFILE=$(find ~/.mozilla/firefox -maxdepth 1 -name '*.default-release' -type d)
ln -sfn ~/dotfiles/firefox/user.js "$PROFILE/user.js"
ln -sfn ~/dotfiles/firefox/chrome "$PROFILE/chrome"
