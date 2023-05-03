#! /bin/sh

chosen=$(printf "  Apagar\n  Reiniciar\n  Suspender\n  Hibernar\n  Salir\n  Bloquear\n⌛ YoutubeMusic" | rofi -dmenu -i -theme-str '@import "power.rasi"')

case "$chosen" in
	"  Apagar") poweroff ;;
	"  Reiniciar") reboot ;;
	"  Suspender") systemctl suspend-then-hibernate ;;
	"  Hibernar") systemctl hibernate ;;
	"  Salir I3") i3-msg  exit ;;
	"  Bloquear") xfce4-session-logout ;;
        "⌛ YoutubeMusic")/home/salion/Documents/Telegram/YouTube-Music-1.19.0.AppImage ;;
	*) exit 1 ;;
esac
