#!/bin/sh
export PATH=$HOME/.local/bin:$PATH

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
xset s off -dpms&
xset b off&
xset s off&
xset -dpms&
compton&
feh --bg-fill $HOME/.wall.jpg &
nm-applet --sm-disable&
#sudo /root/.local/bin/protonvpn c -f&
dunst -config&
browser-x&
password-manager&
/usr/local/bin/st -e /bin/sh -c "tmux new-session -s BASE -n HOME '/bin/zsh'\; split-window 'htop'\; new-window -n MAIL 'neomutt'\; new-window -n NEWSBOAT 'newsboat -r '\; new-window -n MUSIC 'cmus'"&
(sleep 30 && getforecast)&
sudo /usr/bin/rdate -s ntp.task.gda.pl && sudo /sbin/hwclock --systohc
mega-cmd-server --debug-full > /var/log/megacmd/megacmd.log&
dwmstatusbar&
exec dbus-launch dwm
