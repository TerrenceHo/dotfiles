#!/bin/bash
stow -t ~ common

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    stow -t ~ wayland
else
    stow -t ~ xorg
fi
