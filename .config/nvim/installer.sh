#!/bin/bash
# shellcheck disable=2045,2086

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

function install_neovim_module_for_python() {
    pip3 install neovim --pre --user --force
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

function install_terraform() {
    # Install terraform and terraform-ls
    GO111MODULE=on go install github.com/hashicorp/terraform@latest
    GO111MODULE=on go install github.com/hashicorp/terraform-ls@latest
    if [[ "$(uname)" == "Darwin" ]]; then
        brew install tflint
    else
        curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
    fi
}

function install_terragrunt() {
    # Install terragrunt
    if [[ "$(uname)" == "Darwin" ]]; then
        brew install terragrunt
    else
        wget https://github.com/gruntwork-io/terragrunt/releases/latest/download/terragrunt_linux_amd64 -O $HOME/.local/bin/terragrunt
        chmod +x $HOME/.local/bin/terragrunt
    fi
}

function install_shellcheck() {
    # Install shellcheck
    if [[ "$(uname)" == "Darwin" ]]; then
        brew install shellcheck
    else
        curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
    fi
}

function install_gopls() {
    # Install gopls
    GO111MODULE=on go install golang.org/x/tools/gopls@latest
}

function install_black() {
    # Install black
    pip3 install black --pre --user --force
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

function install_azure_cli() {
    pip3 install azure-cli --user --pre --force
}

function install_awscli() {
    pip3 install awscli --pre --user --force
}

function update_zsh() {
    mkdir -p "$ZSHFOLDER/azure-cli" "$ZSHFOLDER/aws"
    for i in $(ls $HOME/.config/zsh); do
        FOLDER="$HOME/.config/zsh/$i"
        cd "$FOLDER" || echo "Folder is not exists"
        git pull
    done
    ZSHFOLDER="$HOME/.config/zsh/"
    curl -s https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/aws/aws.plugin.zsh -o "$ZSHFOLDER"/aws/aws.plugin.zsh
    curl -s https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion -o "$ZSHFOLDER"/azure-cli/az.completion
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
    command_start install_terraform
    command_start install_terragrunt
    command_start install_azure_cli
    command_start install_black
    command_start install_ansible
    command_start install_meraki_ansible
    command_start update_zsh
}

main
