#!/bin/sh
export PATH=$HOME/.local/bin:$PATH

# NVDIA
#xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --setprovideroutputsource NVIDIA-G0 modesetting
xrandr --auto

# Turn off beep
xset b off&

# Lock screen
xset s 600&
xautolock -time 15 -locker slock&

# Programs
dwmblocks&
nm-applet --sm-disable&
dunst -config&
browser-x&
QT_SCALE_FACTOR=1.5 keepassxc &
/usr/local/bin/st -e /bin/sh -c "tmux new-session -s BASE -n HOME '/bin/zsh'\; split-window -h 'watch "grep MHz /proc/cpuinfo | sort -n | tail -n 8 ; sensors"'\; split-window 'htop'\; new-window -n MAIL 'neomutt'\; new-window -n NEWSBOAT 'newsboat -r '\; new-window -n MUSIC 'cmus'"&
sudo /usr/bin/rdate -s ntp.task.gda.pl && sudo /sbin/hwclock --systohc
megasync &
ibus-daemon&

# Two monitors are enabled?
if [[ $(mons | awk '/Monitors/{print $2}') = 2 ]]
then
    xrandr --output HDMI-1 --mode 1920x1080 --rate 60 --primary --output eDP-1 --off
    #xrandr --output eDP-1 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
fi

#compton&
#feh --bg-scale $HOME/.wall.jpg&

# Seetings of LID
#while true
#do
#    if xrandr | grep "HDMI-1 disconnected"; then
#        xrandr --output "HDMI-1" --off --output "eDP-1" --auto
#    #else
#    #    xrandr --output "eDP-1" --off --output "HDMI-1" --auto
#    fi
#
#    if [[ $(< /proc/acpi/button/lid/LID0/state ) = *closed ]] && [[ $(mons | awk '/Monitors/{print $2}') = 1 ]]
#	then
#		case $(< /sys/class/power_supply/ADP0/online) in
#			1) ( [[ ! "$(pidof slock)" ]] && slock ) ;;
#			0) sudo s2ram && slock  ;;
#		esac
#	fi
#	sleep 2
#done &

exec dbus-launch dwm
