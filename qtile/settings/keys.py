# Antonio Sarosi
# https://youtube.com/c/antoniosarosi
# https://github.com/antoniosarosi/dotfiles

# Qtile keybindings

from libqtile.config import Key
from libqtile.command import lazy


mod = "mod4"

keys = [Key(key[0], key[1], *key[2:]) for key in [
    # ------------ Window Configs ------------

    # Switch between windows in current stack pane
    ([mod], "j", lazy.layout.down()),
    ([mod], "k", lazy.layout.up()),
    ([mod], "h", lazy.layout.left()),
    ([mod], "l", lazy.layout.right()),

    # Change window sizes (MonadTall)
    ([mod, "shift"], "l", lazy.layout.grow()),
    ([mod, "shift"], "h", lazy.layout.shrink()),

    # Toggle floating
    ([mod, "shift"], "f", lazy.window.toggle_floating()),

    # Move windows up or down in current stack
    ([mod, "shift"], "j", lazy.layout.shuffle_down()),
    ([mod, "shift"], "k", lazy.layout.shuffle_up()),

    # Toggle between different layouts as defined below
    ([mod], "Tab", lazy.next_layout()),
    ([mod, "shift"], "Tab", lazy.prev_layout()),

    # Kill window
    ([mod], "q", lazy.window.kill()),

    # Switch focus of monitors
    ([mod], "period", lazy.next_screen()),
    ([mod], "comma", lazy.prev_screen()),

    # Restart Qtile
    ([mod, "control"], "r", lazy.restart()),

    ([mod, "control"], "q", lazy.shutdown()),
    ([mod], "r", lazy.spawncmd()),

    # ------------ App Configs ------------

    # Menu
    ([mod], "d", lazy.spawn("rofi -show drun")),

     # nitrogen
    ([mod], "n", lazy.spawn("nitrogen")),

    # Window Nav
    ([mod, "shift"], "m", lazy.spawn("rofi -show")),

    #geary
    ([mod], "x", lazy.spawn("geary")),

    #midori
    ([mod], "z", lazy.spawn("midori")),

    #qutebrowser
    ([mod], "b", lazy.spawn("qutebrowser")),

    # File Explorer
    ([mod], "o", lazy.spawn("pcmanfm")),

    # Terminal
    ([mod], "Return", lazy.spawn("alacritty")),

    # Redshift
    ([mod], "r", lazy.spawn("redshift -O 2400")),
    ([mod, "shift"], "r", lazy.spawn("redshift -x")),

    # Screenshot
    ([mod], "s", lazy.spawn("flameshot")),
    ([mod, "shift"], "s", lazy.spawn("xfce4-screenshooter")),

     # kitty
    ([mod], "t", lazy.spawn("kitty")),
 
     # dmenuangel
    ([mod], "i", lazy.spawn("thunar")),
    
     # dmenuoriginal
    ([mod], "p", lazy.spawn("dmenu_run")),

     #xfce4bateria 
    ([mod], "v", lazy.spawn("xfce4-power-manager")),

     #filezilla
    ([mod], "u", lazy.spawn("filezilla")),

     #conky
    ([mod], "F1", lazy.spawn("conky")),

     #red
    ([mod], "F2", lazy.spawn("nm-applet")),

     #ytm
    ([mod], "F3", lazy.spawn("/home/salion/Documentos/Telegram/YouTube-Music-1.19.0.AppImage")),

   #sesion
    ([mod], "F5", lazy.spawn("/home/salion/Documentos/Telegram/session-desktop-linux-x86_64-1.10.4.AppImage")),


    # ------------ Hardware Configs ------------

    # Volume
    ([], "XF86AudioLowerVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ -5%"
    )),
    ([], "XF86AudioRaiseVolume", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ +5%"
    )),
    ([], "XF86AudioMute", lazy.spawn(
        "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    )),

    # Brightness
    ([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +10%")),
    ([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-")),
]]
