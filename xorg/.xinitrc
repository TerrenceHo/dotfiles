xrdb -merge "$HOME/.Xresources"

export DISPLAY XAUTHORITY
dbus-update-activation-environment --systemd DISPLAY XAUTHORITY

exec i3
