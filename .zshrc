parse_git_branch() {
    git symbolic-ref --short HEAD 2> /dev/null
}

[ -f /etc/gentoo-release ] && export ZSH="/usr/share/zsh/site-contrib/oh-my-zsh"
[ -f /etc/centos-release ] && export ZSH="$HOME/.oh-my-zsh"
[ -f /etc/debian_version ] && export ZSH="$HOME/.oh-my-zsh"

HISTFILE=$HOME/.history_zsh
HISTSIZE=10000
SAVEHIST=10000000
autoload -U colors && colors
setopt PROMPT_SUBST
PS1='%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%m %{$fg[magenta]%}%~%{$fg[red]%} $(parse_git_branch)]%{$reset_color%}$%b '
plugins=(rake ruby vagrant knife knife_ssh kitchen )

ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh
source $HOME/.sshservers
source $HOME/Linux/configs/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh &>> /dev/null
source $HOME/Linux/configs/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh &>> /dev/null
[ ! -d $HOME/.config/fzf ] && git clone https://github.com/junegunn/fzf.git $HOME/.config/fzf
[ -f $HOME/.config/fzf/shell/key-bindings.zsh ] && source $HOME/.config/fzf/shell/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
FPATH=/usr/local/share/zsh/site-functions:$FPATH
xset s off -dpms &>> /dev/null
xset b off &>> /dev/null
xset s off &>> /dev/null
xset -dpms &>> /dev/null
set bell-style none &>> /dev/null
setxkbmap pl &>> /dev/null

export GPG_TTY=$(tty)
export TERM=xterm-256color
export SHELL=/bin/bash
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export _JAVA_AWT_WM_NONREPARENTING=1
export CCACHE_DIR="/usr/ccache"
export LC_ALL="en_US.UTF-8"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export BROWSER=/usr/bin/firefox-bin
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
export EIX_LIMIT_COMPACT=0
export TERMINAL="st"
export QT_SCALE_FACTOR=1.5
export VISUAL='vim'
export EDITOR='vim'
alias svm="sudo vim /etc/portage/make.conf"
alias svr="sudo vim /etc/portage/repos.conf"
alias svp="sudo vim /etc/portage/package.use"
alias emerge="sudo emerge"
alias channel-check='sudo iwlist wlan0 scan | egrep -i "essid|frequency"'
alias grep="grep --color=always"
alias egrep="egrep --color=always"
alias ls='ls -h --color=auto'
alias ll='ls -lha'
alias myip="curl ipinfo.io/ip"
alias logi="journalctl -f"
alias pl="setxkbmap pl"
alias graphic-card="glxinfo|egrep 'OpenGL vendor|OpenGL renderer'"
alias mylaptop-components="inxi -Fxz"
alias r="ranger"
alias v="vim"
alias feh="feh --scale-down"
alias changefont="figlet"
alias gmaster="git checkout master"
alias gcommit="git commit --author='Marcin Woźniak <y0rune@aol.com>' -s"
alias gcommitwork="git commit --author='Marcin Woźniak <marcin.wozniak@cognifide.com>'"
alias gadd="git add"
alias gpush="git push"
alias gpull="git pull"
alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --branches"
alias gfg="git checkout master && git fetch upstream && git pull upstream master"
alias cal="cal -3"
alias code="vscodium"
alias vpn="sudo /root/.local/bin/protonvpn c -f"
alias vpnch="sudo /root/.local/bin/protonvpn c --cc CH"
alias vpnd="sudo /root/.local/bin/protonvpn d"
alias prolog="swipl"
alias tv="~/MEGA/tv/tv.sh"
alias newswork="newsboat --url=$HOME/.config/newsboat/urlswork"
alias vim="vim -p"
alias denpl="trans en:pl"
alias dplen="trans pl:en"
alias notes="vim $HOME/git/notes/index.md"

# Cleaning-up
export PATH=$HOME/.local/bin:$PATH
XDG_DATA_DIRS="$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"
