#!/bin/env sh

# This script sets up a custom status bar for the dwm window manager.
# The status bar includes information such as CPU load, battery level,
# package updates, brightness, memory usage, wireless network status, and
# the current time.

# Color codes for the status bar. These can be used in the format ^c$color^ and ^b$color^
# to set the foreground and background colors of different sections of the bar.

interval=0

theme=catppuccin

set_color(){
  case $theme in 
    'catppuccin') 
      black=#1E1D2D
      green=#ABE9B3
      white=#D9E0EE
      grey=#282737
      blue=#96CDFB
      red=#F28FAD
      darkblue=#83bae8 ;;
    'dracula')
      black=#21222c
      green=#50fa7b
      white=#f8f8f2
      grey=#282a36
      blue=#d6acff
      red=#ff5555
      darkblue=#bd93f9 ;;
    'gruvchad')
      black=#222526
      green=#89b482
      white=#c7b89d
      grey=#2b2e2f
      blue=#6f8faf
      red=#ec6b64
      darkblue=#6080a0 ;;
    'nord')
      black=#2E3440
    green=#A3BE8C
    white=#D8DEE9
    grey=#373d49
    blue=#81A1C1
    red=#BF616A
    darkblue=#7292b2 ;;
  'onedark')
    black=#1e222a
    green=#7eca9c 
    white=#abb2bf
    grey=#282c34
    blue=#7aa2f7
    red=#d47d85
    darkblue=#668ee3
  esac
}
set_color

cpu() {
  cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)
  printf "%s" "^c$black^ ^b$green^ CPU"
  printf "%s" "^c$white^ ^b$grey^ $cpu_val"
}

pkg_updates() {
  #updates=$({ timeout 20 doas xbps-install -un 2>/dev/null || true; } | wc -l) # void
  updates=$({ timeout 20 checkupdates 2>/dev/null || true; } | wc -l) # arch
  # updates=$({ timeout 20 aptitude search '~U' 2>/dev/null || true; } | wc -l)  # apt (ubuntu, debian etc)

  if [ "$updates" -eq 0 ]; then
    printf "%s" "  ^c$green^    Actualizado"
  else
    printf "%s" "  ^c$green^    $updates"" No Actualizado"
  fi
}

battery() {
  get_status=$(cat /sys/class/power_supply/BAT?/status)
  get_capacity=$(cat /sys/class/power_supply/BAT?/capacity)
  # Set battery icon based on capacity and status
  if [ "$get_status" = "Discharging" ]; then
    if [ "$get_capacity" -ge 90 ]; then
      icon=" "
    elif [ "$get_capacity" -ge 70 ]; then
      icon=" "
    elif [ "$get_capacity" -ge 40 ]; then
      icon=" "
    elif [ "$get_capacity" -ge 10 ]; then
      icon=" "
    else
      icon=" "
    fi
  else
    icon=" "
  fi

  printf "^c$blue^ %s $icon $get_capacity"
}

mem() {
  printf "%s" "^c$blue^^b$black^  "
  printf "%s" "^c$blue^ $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

wlan() {
  case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
    up) printf "^c$black^ ^b$blue^ 󰤨 ^d^%s" " ^c$blue^Conectado" ;;
    down) printf "^c$black^ ^b$blue^ 󰤭 ^d^%s" " ^c$blue^Desconectado" ;;
  esac
}

clock() {
  printf "%s" "^c$black^ ^b$darkblue^ 󱑆 "
  printf "%s" "^c$black^^b$blue^$(date '+%d/%m/%y %H:%M') "
}

while true; do

  [ $interval = 0 ] || [ $((interval % 3600)) = 0 ] && updates=$(pkg_updates)
  interval=$((interval + 1))

  sleep 1 && xsetroot -name "$updates $(battery) $(cpu) $(mem) $(wlan) $(clock)"
done
