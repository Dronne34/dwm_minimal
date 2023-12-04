#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi
# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# exec xss-lock  --transfer-sleep-lock -- ~/.config/i3/scripts/lock --nofork & 
# exec nitrogen --set-auto --random ~/.config/screen/ &
# exec float "$@" | ${SHELL:-"/bin/sh"} &
# exec conky -c ~/.config/conky/clock.conf &
# exec slstatus &
# dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY &
exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
exec picom --config  ~/.config/picom/picom.conf  &
exec nitrogen --restore &
exec xrandr -s 1920x1080 &
exec xrdb -merge ~/.Xresources &
exec chmod u+x .local/bin/* &
exec eval "$(ssh-agent -s)"  &
exec sxhkd &
# exec xbindkeys &
exec dunst &
exec play_with_mpv &
exec dwmblocks & 
exec ~/.local/bin/relaunch 
exec dwm
