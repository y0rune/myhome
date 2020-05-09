#!/bin/sh
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
xset s off -dpms&
xset b off&
xset s off&
xset -dpms&
compton&
feh --bg-fill $HOME/.wall.jpg &
redshift -l 53.2327:18.3036 -t 6500:3200&
nm-applet --sm-disable&
/usr/local/bin/st -e /bin/sh -c "tmux new-session -s BASE -n HOME '/bin/zsh'\; split-window -h 'newsboat'\; split-window 'cmus'\; split-window 'htop'"&
sudo /root/.local/bin/protonvpn c -f&
google-chrome-stable --force-device-scale-factor=1.25&
thunderbird-bin&
sudo keepassxc&
dunst -config&
transmission-daemon&
(sleep 30 && getforecast)&
sudo /usr/bin/rdate -s -l ntp.task.gda.pl && sudo /sbin/hwclock --systohc
/opt/MEGAcmd/mega-cmd-server --debug-full > /var/log/megacmd/megacmd.log&
discord&
dwmstatusbar&
exec dbus-launch dwm 
