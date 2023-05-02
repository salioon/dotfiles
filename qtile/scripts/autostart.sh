#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

#start sxhkd to replace Qtile native key-bindings
run sxhkd -c ~/.config/qtile/sxhkd/sxhkdrc &
pcloud &
start mpd
[ ! -s ~/.config/mpd/pid ] && mpd &

setxkbmap -option ctrl:nocaps &
clipmenud &
dunst &

#starting utility applications at boot time
picom --vsync &
/usr/libexec/polkit-gnome-autentication-agent-1 &
#/usr/lib/xfce4/notifyd/xfce4-notifyd &
~/.fehbg &
