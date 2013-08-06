#!/usr/bin/env bash
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

(setxkbmap; /usr/bin/xmodmap /home/brncsk/.Xmodmap; sleep 2; /data/dev/futerm/futerm)&
gnome-session --session=custom
gala --replace
