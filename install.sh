#!/bin/bash
stow -t ~ common

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    stow -t ~ wayland
else
    stow -t ~ xorg
fi

PROFILE=$(find ~/.mozilla/firefox -maxdepth 1 -name '*.default-release' -type d)
ln -sf ~/dotfiles/firefox/user.js "$PROFILE/user.js"
ln -sf ~/dotfiles/firefox/chrome "$PROFILE/chrome"
