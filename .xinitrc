#!/bin/sh
export PATH=$HOME/.local/bin:$PATH

# NVDIA
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

# Turn off beep
xset b off&

# Lock screen
xset s 600&
xautolock -time 15 -locker slock&

# Programs
compton&
feh --bg-fill "$HOME/.wall.jpg" &
nm-applet --sm-disable&
#sudo /root/.local/bin/protonvpn c -f&
dunst -config&
browser-x&
password-manager&
/usr/local/bin/st -e /bin/sh -c "tmux new-session -s BASE -n HOME '/bin/zsh'\; split-window 'htop'\; new-window -n MAIL 'neomutt'\; new-window -n NEWSBOAT 'newsboat -r '\; new-window -n MUSIC 'cmus'"&
#(sleep 30 && getforecast)&
sudo /usr/bin/rdate -s ntp.task.gda.pl && sudo /sbin/hwclock --systohc
#mega-cmd-server --debug-full > /var/log/megacmd/megacmd.log&
mega-cmd-server > /var/log/megacmd/megacmd.log&
setxkbmap pl&
dwmstatusbar&

# Two monitors are enabled?

if [[ $(mons | awk '/Monitors/{print $2}') = 2 ]]
then
    xrandr --output eDP-1 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
fi

# Seetings of LID
while true
do
    if [[ $(< /proc/acpi/button/lid/LID0/state ) = *closed ]] && [[ $(mons | awk '/Monitors/{print $2}') = 1 ]]
	then
		case $(< /sys/class/power_supply/ADP0/online) in
			1) ( [[ ! "$(pidof slock)" ]] && slock ) ;;
			0) sudo pm-suspend && slock  ;;
		esac
	fi
	sleep 2
done &

exec dbus-launch dwm
