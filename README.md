# Dotfiles

Consolidating dotfiles across multiple repositories. Using `stow` to save configs across my different machines

## Setting Up

```
stow -t ~ common

# for xorg desktops
stow -t ~ xorg

# for wayland desktops
stow -t ~ wayland
```
