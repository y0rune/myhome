# ZSHRC

CONFIG=$HOME/.config

parse_git_branch() {
    command=$(git branch \
        2> /dev/null \
        | sed -n -e 's/^\* \(.*\)/\1/p' \
        | awk 'NF{print $NF}' \
        | sed 's/)//g' \
        2> /dev/null)
    [ -z $command ] && echo -e "$ " || echo -e "$command $ "
}

gbranch() {
    echo -e "$(git branch "$@")"
}

[ -f /etc/gentoo-release ] && export ZSH="/usr/share/zsh/site-contrib/oh-my-zsh"
[ -f /etc/centos-release ] && export ZSH="$HOME/.oh-my-zsh"
[ -f /etc/debian_version ] && export ZSH="$HOME/.oh-my-zsh"
[[ "$(uname)" == "Darwin" ]] && export ZSH="$HOME/.oh-my-zsh"

HISTFILE=$HOME/.history_zsh
HISTSIZE=10000
SAVEHIST=10000000
autoload -U colors && colors
setopt PROMPT_SUBST
PS1='%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%}%n@)%m %{$fg_bold[blue]%}%(!.%1~.%~) $(parse_git_branch)%{$reset_color%}'
plugins=(rake ruby vagrant knife knife_ssh kitchen )

ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

[ ! -d $CONFIG/zsh/aws ] && { mkdir -p $CONFIG/zsh/aws ; cd $CONFIG/zsh ; git clone https://github.com/popstas/zsh-command-time.git ; git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ; git clone https://github.com/zsh-users/zsh-autosuggestions.git ; curl https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/aws/aws.plugin.zsh -o $CONFIG/zsh/aws/aws.plugin.zsh }
[ -d $CONFIG/zsh ] && source $CONFIG/zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh &>> /dev/null
[ -d $CONFIG/zsh ] && source $CONFIG/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh &>> /dev/null
[ -d $CONFIG/zsh ] && source $CONFIG/zsh/zsh-command-time/command-time.plugin.zsh &>> /dev/null
[ -d $CONFIG/zsh ] && source $CONFIG/zsh/aws/aws.plugin.zsh &>> /dev/null
[ -f $HOME/.password ] && source $HOME/.password
[ ! -d $CONFIG/fzf ] && git clone https://github.com/junegunn/fzf.git $HOME/.config/fzf
[ -f $CONFIG/fzf/shell/key-bindings.zsh ] && source $HOME/.config/fzf/shell/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
FPATH=/usr/local/share/zsh/site-functions:$FPATH

# Configuration of command-time
# If command execution time above min. time, plugins will not output time.
ZSH_COMMAND_TIME_MIN_SECONDS=10
ZSH_COMMAND_TIME_MSG="Execution time: %s sec"
ZSH_COMMAND_TIME_EXCLUDE=(ranger git nvim fzf vim mcedit v ssh lg lazygit)

export GPG_TTY=$(tty)
# export TERM=xterm-256color
export TERM=screen-256color
export SHELL=/bin/bash
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
export _JAVA_AWT_WM_NONREPARENTING=1
export CCACHE_DIR="/usr/ccache"
export LC_ALL="en_US.UTF-8"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export BROWSER=/home/yorune/.local/bin/browser-x
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
export EIX_LIMIT_COMPACT=0
export TERMINAL="st"
export QT_SCALE_FACTOR=1.5
export VISUAL='nvim'
export EDITOR='nvim'
alias vimc="nvim $HOME/.vimrc"
alias svm="sudo nvim /etc/portage/make.conf"
alias svr="sudo nvim /etc/portage/repos.conf"
alias svp="sudo nvim /etc/portage/package.use"
alias sva="sudo nvim /etc/portage/package.accept_keywords"
alias emerge="sudo emerge"
alias channel-check='sudo iwlist wlan0 scan | egrep -i "essid|frequency"'
alias grep="grep"
alias egrep="egrep"
alias ls="ls -h --color=auto"
alias ll='ls -lha'
alias cp='cp -v'
alias mv='mv -v'
alias myip="curl ipinfo.io/ip"
alias logi="journalctl -f"
alias pl="setxkbmap pl"
alias graphic-card="glxinfo|egrep 'OpenGL vendor|OpenGL renderer'"
alias mylaptop-components="inxi -Fxz"
alias r="ranger"
alias v="nvim"
alias feh="feh --edit --scale-down"
alias changefont="figlet"
alias gmaster="git checkout master"
alias gcommit="git commit --author='Marcin Woźniak <y0rune@aol.com>' -s"
alias gcommitw="git commit --author='Marcin Wozniak <marcin.wozniak@wundermanthompson.com>'"
alias gdel="git push origin --delete"
alias gadd="git add"
alias gpush="git push"
alias gpull="git fetch -p -q; git pull; git submodule foreach git pull origin master -q; git submodule foreach git pull origin main -q; git submodule status"
alias gstatus="git status -s"
alias gst="git status -s"
alias gdiff="git diff"
alias gnew="git checkout -b"
alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --branches"
alias cal="cal -3"
alias code="vscodium-bin"
alias tv="~/MEGA/tv/tv.sh"
alias newswork="newsboat --url=$HOME/.config/newsboat/urlswork"
alias vim="nvim -p"
alias denpl="trans en:pl"
alias dplen="trans pl:en"
alias notes="nvim $HOME/git/notes/index.md"
alias mpv="__NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0 __GLX_VENDOR_LIBRARY_NAME=nvidia __GL_SYNC_TO_VBLANK=0 mpv --vo=x11 --hwdec=no --ytdl-raw-options="yes-playlist=" --no-resume-playback --ytdl-format='bestvideo[height<=?1080]+bestaudio/best'"
alias aria2c="aria2c --seed-time=0 --disable-ipv6 --max-upload-limit=1k"
alias lg="lazygit"
alias update-brew="brew upgrade --cask"
alias irc="ssh mikrus -t 'screen -r'"
alias rsync="rsync --progress"

# Cleaning-up
export PATH=$HOME/.local/bin:$PATH
export PATH=/sbin:$PATH
export GOPATH=$HOME/golang
export GOROOT=/usr/lib/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$HOME/.gem/ruby/2.6.0/bin
[ -d $HOME/repo/fortigate/bin ] && export PATH=$HOME/repo/fortigate/bin:$PATH
export HISTTIMEFORMAT="%F %T "

# Export for WSL
if [[ "$(uname -sr)" =~ "Microsoft" ]]; then
    export GOROOT=/usr/lib/go
fi

# Export for Mac
if [[ "$(uname)" == "Darwin" ]]; then
    # Resolve problem with GOPATH
    # https://stackoverflow.com/questions/66284870/go-get-not-downloading-to-src-folder
    export GO111MODULE=off

    # Other export
    export PATH="/usr/local/opt/openssl@3/bin:$PATH"
    export PATH=$PATH:$HOME/Library/Python/3.9/bin
    export PATH=$PATH:/usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/bin
    export LDFLAGS="-L/usr/local/opt/openssl@3/lib"
    export CPPFLAGS="-I/usr/local/opt/openssl@3/include"
    export PKG_CONFIG_PATH="/usr/local/opt/openssl@3/lib/pkgconfig"

    alias lsblk="diskutil list"
    alias Update="brew update; brew upgrade"
    alias ls="ls -Gh"
    alias mpv="mpv --no-resume-playback"
    alias code="open -a 'Visual Studio Code'"
fi

# Resolve problem with
# zsh: no matches found
setopt +o nomatch

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
