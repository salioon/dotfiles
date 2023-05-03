if status is-interactive
    # Commands to run in interactive sessions can go here
end

#coloresfish
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'


# You may need to manually set your language environment
#export LANG=en_US.UTF-8
#export LANG=es_ES.UFT-8
# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='lvim'
# else
   export EDITOR='nvim'
# fi

alias lvim="/home/salion/.local/bin/lvim"


# Color output of ip
alias ip="ip -color"

# Changing "ls" to "exa"
alias ls-1="ls -l |lolcat"
alias ls-2="ls -a |lolcat"
alias lf-l='exa -al --color=always --icons --group-directories-first' # my preferred listing
alias la='exa -a --color=always --icons --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --icons --group-directories-first'  # long format
alias lt='exa -aT --color=always --icons --group-directories-first' # tree listing
alias l.='exa -a | grep -E "^\."' #show only hidden files
alias tree='exa --icons  -T' # tree listing

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'


#comandos
alias ram="free -mt"
alias discoespacio='sudo df -h | grep -E "sd|lv|Size"'
alias correo="neomutt"
alias bajarcorreo="mbsync -a"
alias limpiador="sudo bleachbit"
alias pantallafix="exec /home/salion/.screenlayout/pantalla.sh"
alias zshconfig="sudo nano /home/salion/.zshrc"
alias fishconfig="sudo nano /home/salion/.config/fish/config.fish"
alias zshconfig2="sudo nano /root/.zshrc"
alias bashedit="sudo nano /home/salion/.bashrc"
alias bashedit2="sudo nano /root/.bashrc"
alias ssdtrim='sudo fstrim / -v'
alias teror='curl wttr.in/teror'
alias arucas='curl wttr.in/arucas'
alias newyork='curl wttr.in/ny'
alias barcelona='curl wttr.in/barcelona'
alias vm='sudo virt-manager'
alias cualip='curl ifconfig.me'
alias TorBrowser='flatpak run com.github.micahflee.torbrowser-launcher'
alias verpuertos='sudo ss -tupln'
alias verconexion='netstat -watp'
alias ifconfig2='ip addr'
#alias bloqueardns='sudo chattr +i /etc/resolv.conf'
alias bloquear='sudo nano /etc/hosts'
alias editardns='sudo nano /etc/resolv.conf'


#pacman
alias update='sudo pacman -Sy'
alias update2='sudo pacman -Syu'
alias update3="sudo paru -Sy"
alias update4="sudo paru -Syu"
alias update5="sudo yay -Sy"
alias update6="sudo yay -Syu"
alias update7='flatpak update'
alias limpiar="sudo pacman -Sc"
alias limpiar2="sudo paru -Sc"
alias limpiar3="sudo yay -Sc"
alias limpiador="sudo bleachbit"


#bateria
alias bateria='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias bate='upower -i /org/freedesktop/UPower/devices/battery_BAT0| grep -E "state|to\ full|percentage"'


#aliasDirectorio

alias ls='ls -lh --color=auto'

#alias ls='ls -l |lolcat'

#alias la='ls -a'

alias dir='dir --color=auto'

alias vdir='vdir --color=auto'

alias grep='grep --color=auto'

alias fgrep='fgrep --color=auto'

alias egrep='egrep --color=auto'


#utiles2
alias comprimir="flatpak run org.gnome.FileRoller"
alias rss="newsboat"
alias editrss="sudo nano /home/salion/.newsboat/urls"
alias disco="df -h |lolcat "
alias disco2="df |lolcat"
alias reiniciar="sudo reboot"
alias espacio="ncdu |lolcat"
alias arbol="ncdu |lolcat"
alias vncremoto="vncserver :0"
alias vncremoto1="vncserver :1"
alias apagar="sudo poweroff"
alias grubfix="grub2-mkconfig -o /boot/grub/grub.cfg"
alias fixrefind"sudo refind-install"
alias admin="su"


#lunarvim
alias lunar-sync="lvim +PackerSync"
alias lunar-update="lvim +LvimUpdate +q"
alias lunar-plugins="lvim +LvimSyncCorePlugins +q"

#Neovim
alias nvim-sync="nvim +:Lazy update"
alias nvim-update="nvim +NvimUpdate +q"
alias nvim-pluginsv2="nvim +NvimSyncCorePlugins +q"


#menurofi
 alias menu='rofi -show drun'
 alias menu-v='rofi -show run '
 alias menu-tab='rofi -show '
 
 #microeditor
 alias micro=" kitty -e /home/salion/Documentos/Telegram/micro/micro-2.0.11/micro"


alias IPTOR="curl https://check.torproject.org"
alias torON="sudo tor start"
alias torStatus="sudo tor status"
alias torOFF="sudo tor stop"
alias TORserveron="sudo systemctl enable tor.service"
alias TORserveroff="sudo systemctl disable tor.service"
alias TorStat="ps -A  | grep tor"

#wireguard
alias wireon="sudo wg-quick up wg0"
alias wireoff="sudo wg-quick down wg0"
alias wire-usa-on="sudo wg-quick up wg1"
alias wire-usa-off="sudo wg-quick down wg1"
alias wire-jp-on="sudo wg-quick up wg2"
alias wire-jp-off="sudo wg-quick down wg2"

#lvm2
#alias lvmoff="sudo vgchange -a n /dev/pve"
#alias editarlvm="sudo nano /etc/libblockdev/conf.d/00-default.cfg"

#lvmoff
inxi -Gx
uname -arsv 
screenfetch |lolcat

