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
HISTSIZE=10000000
SAVEHIST=10000000
autoload -U colors && colors
autoload bashcompinit && bashcompinit
setopt PROMPT_SUBST
PS1='%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%}%n@)%m %{$fg_bold[blue]%}%(!.%1~.%~) $(parse_git_branch)%{$reset_color%}'
plugins=(rake ruby vagrant knife knife_ssh kitchen )

ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

[ -d $CONFIG/zsh/zsh-autosuggestions ] && source $CONFIG/zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh &>> /dev/null
[ -d $CONFIG/zsh/zsh-syntax-highlighting ] && source $CONFIG/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh &>> /dev/null
[ -d $CONFIG/zsh/zsh-command-time ] && source $CONFIG/zsh/zsh-command-time/command-time.plugin.zsh &>> /dev/null
[ -d $CONFIG/zsh/aws ] && source $CONFIG/zsh/aws/aws.plugin.zsh &>> /dev/null
[ -d $CONFIG/zsh/azure-cli ] && source $CONFIG/zsh/azure-cli/az.completion &>> /dev/null
[ -f $HOME/.password ] && source $HOME/.password
[ -f $CONFIG/fzf/shell/key-bindings.zsh ] && source $HOME/.config/fzf/shell/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
FPATH=/usr/local/share/zsh/site-functions:$FPATH

# Configuration of command-time
# If command execution time above min. time, plugins will not output time.
ZSH_COMMAND_TIME_MIN_SECONDS=10
ZSH_COMMAND_TIME_MSG="Execution time: %s sec"
ZSH_COMMAND_TIME_EXCLUDE=(ranger git nvim fzf vim mcedit v ssh lg lazygit tmux)

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
export BROWSER=/home/yorune/.local/bin/browser-x
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
export EIX_LIMIT_COMPACT=0
export TERMINAL="st"
export QT_SCALE_FACTOR=1.5

# Declerating the PATHs
unset PATH
export PATH=/bin:$PATH
export PATH=/usr/bin:$PATH
export PATH=/usr/sbin:$PATH
export PATH=/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/golang/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/node_modules/.bin:$PATH
export GOPATH=$HOME/golang
export PATH=$PATH:$HOME/.gem/ruby/2.6.0/bin
[ -d $HOME/repo/fortigate/bin ] && export PATH=$HOME/repo/fortigate/bin:$PATH

# History
export HISTTIMEFORMAT="%F %T "

# Export for WSL
if [[ "$(uname -sr)" =~ "Microsoft" ]]; then
    export GOROOT=/usr/lib/go
fi

# Alias ssh
alias ssh-work="ssh -i ~/.ssh/work/id_rsa"
alias ssh-restore="cp -rv ~/ssh-mega/config ~/.ssh/ ; ssh-permissions"
alias ssh-backup="cp -rv ~/.ssh/config ~/ssh-mega/"

# Alias and Export Gentoo
alias svm="sudo $EDITOR /etc/portage/make.conf"
alias svr="sudo $EDITOR /etc/portage/repos.conf"
alias svp="sudo $EDITOR /etc/portage/package.use"
alias sva="sudo $EDITOR /etc/portage/package.accept_keywords"
alias emerge="sudo emerge"
alias mpv="__NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0 __GLX_VENDOR_LIBRARY_NAME=nvidia __GL_SYNC_TO_VBLANK=0 mpv --vo=x11 --hwdec=no --ytdl-raw-options="yes-playlist=" --no-resume-playback --ytdl-format='bestvideo[height<=?1080]+bestaudio/best'"
alias code="vscodium-bin"
alias pl="setxkbmap pl"
alias feh="feh --edit --scale-down"
alias graphic-card="glxinfo|egrep 'OpenGL vendor|OpenGL renderer'"
alias mylaptop-components="inxi -Fxz"

# Alias and Export for Mac
if [[ "$(uname)" == "Darwin" ]]; then
    # Resolve problem with GOPATH
    # https://stackoverflow.com/questions/66284870/go-get-not-downloading-to-src-folder
    export GO111MODULE=on

    # Other export
    export PATH="/usr/local/opt/openssl@3/bin:$PATH"
    export PATH="/opt/homebrew/bin:$PATH"
    export LDFLAGS="-L/usr/local/opt/openssl@3/lib"
    export CPPFLAGS="-I/usr/local/opt/openssl@3/include"
    export PKG_CONFIG_PATH="/usr/local/opt/openssl@3/lib/pkgconfig"
    export GOROOT="$(brew --prefix golang)/libexec"
    export PATH=$PATH:$GOPATH/bin
    export PATH=$PATH:$GOROOT/bin

    export PYTHONVERSION=$(ls -la /opt/homebrew/opt/ |
        grep -iEo 'python@.* ->' |
        sed 's/ ->//g'|
        sort |
        tail -n1 |
        sed 's/python@//g')

    export PATH=$PATH:$HOME/Library/Python/$PYTHONVERSION/bin
    export PATH=$PATH:/usr/local/opt/python@$PYTHONVERSION/Frameworks/Python.framework/Versions/$PYTHONVERSION/bin
    export PATH="$(brew --prefix python@$PYTHONVERSION)/bin:$PATH"
    alias python3='/opt/homebrew/bin/python$PYTHONVERSION'
    alias pip3='/opt/homebrew/bin/pip$PYTHONVERSION'
    alias python='/opt/homebrew/bin/python$PYTHONVERSION'
    alias pip='/opt/homebrew/bin/pip$PYTHONVERSION'

    alias lsblk="diskutil list"
    alias Update="~/.local/bin/Update-pkg; brew update; brew upgrade"
    alias ls="ls -Gh"
    alias mpv="mpv --ytdl-raw-options="yes-playlist=" --no-resume-playback --ytdl-format='bestvideo[height<=?1080]+bestaudio/best'"
    alias code="open -a 'Visual Studio Code'"
    alias xclip="pbcopy"

    # Project
    alias meraki="cd $HOME/git/ansible_collections/cisco/meraki/"
fi

# Setting the right editor
if which nvim > /dev/null 2>&1; then
    export VISUAL='nvim -u $HOME/.vimrc'
    export EDITOR='nvim -u $HOME/.vimrc'
else
    export VISUAL='vim -u $HOME/.vimrc-def'
    export EDITOR='vim -u $HOME/.vimrc-def'
fi

# Vim
alias vimc="$EDITOR $HOME/.vimrc"
alias v="$EDITOR -p"
alias vim="$EDITOR -p"

# Commands
alias rsync="rsync -h --progress"
alias lg="lazygit"
alias ldocker="lazydocker"
alias ls="ls -h --color=auto"
alias ll='ls -lha'
alias r="ranger"
alias cp='cp -v'
alias mv='mv -v'
alias cal="cal -3"
alias denpl="trans en:pl"
alias dplen="trans pl:en"
alias myip="curl ipinfo.io/ip"
alias changefont="figlet"

# Git
alias gmaster="git checkout master; git checkout main"
alias gmain="git checkout master; git checkout main"
alias gcommit="git commit --author='Marcin Woźniak <y0rune@aol.com>' -s"
alias gcommitw="git commit --author='Marcin Wozniak <marcin.wozniak@wundermanthompson.com>'"
alias gdel="git push origin --delete"
alias gadd="git add"
alias gpush="git push"
alias gpull="git fetch -p -q; git pull; git submodule foreach git pull origin master -q; git submodule foreach git pull origin main -q; git submodule status"
alias gpu="git fetch -p -q; git pull; git submodule foreach git pull origin master -q; git submodule foreach git pull origin main -q; git submodule status"
alias gch="git checkout"
alias gst="git status -s"
alias gdiff="git --no-pager diff"
alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --branches"
alias gshow="git --no-pager show --color --pretty=format:%b"
alias gd=gshow

# Others
alias channel-check='sudo iwlist wlan0 scan | egrep -i "essid|frequency"'
alias newswork="newsboat --url=$HOME/.config/newsboat/urlswork"
alias aria2c="aria2c --seed-time=0 --disable-ipv6 --max-upload-limit=1k"
alias irc="ssh mikrus -t 'screen -r'"

# Resolve problem with - zsh: no matches found
setopt +o nomatch

# Error with icu
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

# Error with Delinea - Linux
[ -f "/etc/ssl/certs/ca-certificates.crt" ] && export REQUESTS_CA_BUNDLE='/etc/ssl/certs/ca-certificates.crt'
