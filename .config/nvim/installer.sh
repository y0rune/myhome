#!/bin/bash

function timestamp() {
    echo "[+] $(date +'%F %T') [INFO] $*"
}

function err() {
    echo "[-] $(date +'%F %T') [ERROR] $*" >&2
}

function command_start() {
    timestamp "Command $* has been started."
    if ! "$*"; then
        err "Command $* went wrong."
    fi
    timestamp "Command $* has been ended."
}

function update_pip() {
    python3 -m pip install --upgrade pip --user
}

function install_pyright() {
    # Install pyright
    sudo npm -g i pyright --force
}

function install_bash-language-server() {
    # Install bash-language-server
    sudo npm -g i bash-language-server --force
}

function install_yaml-language-server() {
    # Install yaml-language-server
    sudo npm -g i yaml-language-server --force
}

function install_shfmt() {
    # Install shfmt
    GO111MODULE=on go install mvdan.cc/sh/v3/cmd/shfmt@latest
}

function install_shellcheck() {
    # Install shellcheck
    [[ "$(uname)" == "Darwin" ]] && brew install shellcheck
    sudo emerge shellcheck-bin
}

function install_gopls() {
    # Install gopls
    GO111MODULE=on go install golang.org/x/tools/gopls@latest
}

function install_black() {
    # Install black
    pip3 install black --user --force
}

function install_ansible() {
    pip3 install --pre --user ansible ansible-lint ansible-core --force
}

function install_ansible-language-server() {
    # Install ansible-language-server
    sudo npm -g i @ansible/ansible-language-server --force
    sudo npm -g i yaml-language-server --force
}

function install_meraki_ansible() {
    ansible-galaxy collection install cisco.meraki --force
    pip3 install meraki --user --force
}

function main() {
    command_start update_pip
    command_start install_pyright
    command_start install_bash-language-server
    command_start install_yaml-language-server
    command_start install_ansible-language-server
    command_start install_shfmt
    command_start install_shellcheck
    command_start install_gopls
    command_start install_black
    command_start install_ansible
    command_start install_meraki_ansible
}

main
