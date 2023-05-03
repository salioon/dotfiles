#!/usr/bin/env bash
# rofi menu to:
# - enable second display as mirrored
# - enable second display as second monitor
# - disable default display
# - disable second display

# if your outputs names are different you need to change

rofi="rofi -dmenu -i -p"

_reload_wallpaper() {
DIR="$HOME/.config/wall"
pidof "xwallpaper" && killall "xwallpaper"
xargs xwallpaper --stretch < "$DIR"
}

_second_as_monitor(){
declare -a options=(
"left"
"right"
"above"
"below")

    SIDE=$(printf '%s\n' "${options[@]}" | ${rofi} 'Display option: ')
    case $SIDE in 
    "left") xrandr --output "$DEFAULT" --auto --output "$SECOND" --left-of "$DEFAULT" ;;
    "right") xrandr --output "$DEFAULT" --auto --output "$SECOND" --right-of "$DEFAULT" ;;
    "above") xrandr --output "$DEFAULT" --auto --output "$SECOND" --above "$DEFAULT" ;;
    "below") xrandr --output "$DEFAULT" --auto --output "$SECOND" --below "$DEFAULT" ;;
    *) exit 0 ;;
    esac

}

switch_audio_output(){
DEVICES=$(pacmd list-cards | awk '/name:/ {print $2}' | sed -e 's/[<>]//g')
PROFILES=$(pacmd list-cards | grep -A 9 'profiles' | grep -v 'profiles' | awk -F ':' '{print $1":"$2":"$3}' | awk '{print $1}')

if [[ "$(echo -e "No\nYes" | ${rofi} "you want to change the audio profile")" == "Yes" ]]; then
Selected_Profile=$(printf '%s\n' "${PROFILES[@]}" | ${rofi} 'available profiles:')
#change the default audio output device to the selected device
pacmd set-card-profile "$DEVICES" "$Selected_Profile"
fi
}


main(){
    # Get the current connected monitors
    connected_monitors=$(xrandr | grep " connected" | awk '{print $1 }'| tr '\n' ' ')
    number_of_monitors=$(echo "$connected_monitors" | wc -w)
    if [ "$number_of_monitors" -eq 2 ]
    then
    declare -a options=(
    "Second as monitor"
    "Second as mirror"
    "Second disabled"
    "Default disabled")
    
     DEFAULT=$(echo "$connected_monitors" | awk '{print $1}')
     SECOND=$(echo "$connected_monitors" | awk '{print $2}')
     choice=$(printf '%s\n' "${options[@]}" | ${rofi} 'Display option:' "${@}")
     case $choice in 
    'Second as monitor')_second_as_monitor;;
    'Second as mirror')xrandr --output "$DEFAULT" --auto --output "$SECOND" --same-as "$DEFAULT" && _reload_wallpaper;;
    'Second disabled')xrandr --output "$SECOND" --off --output "$DEFAULT" --auto;;
    'Default disabled')switch_audio_output && xrandr --output "$DEFAULT" --off --output "$SECOND" --auto --pos 0x0 --rotate normal && _reload_wallpaper;;
    *)exit 0 ;;
esac
else
      echo "Error: Please connect two monitors."
  fi
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"
