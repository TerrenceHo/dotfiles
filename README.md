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

# System Dependencies

System dependencies are managed with copies, because we shouldn't symlink to a
home directory for system dependencies. If there are post install hooks for
particular configs (such as systemctl reloads) those will be automatically run.

## System Install Usage

To install and interactively show diffs:
```
sudo ./system/install.sh          # install, prompting on changes
```

To only show changes:
```
sudo ./system/install.sh --diff   # dry run, only show diffs
```

Overwrite all system dependencies without prompting:
```
sudo ./system/install.sh --force  # overwrite without prompting
```

