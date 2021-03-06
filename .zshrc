#!/bin/zsh
# profiling
if [ "$PROFILING" ]
then
    zmodload zsh/zprof
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="spaceship"
#ZSH_THEME="ys"
#ZSH_THEME="honukai"

plugins=(
    git
    osx
    docker
    encode64
    history
    pip
    python
    sudo
    # brew
    common-aliases
    zsh-syntax-highlighting
    # proxy
    zsh-autosuggestions
    kubectl-switch
    lazy
    base64
    # kubectl
    # autojump
    # node
    # npm
    # catimg
    # httpie
    # autopep8
    # redis-cli
    # lua
    # zsh-wakatime
    # navi
)

# zsh spaceship prompt config
SPACESHIP_TIME_SHOW=true
SPACESHIP_KUBECTL_SHOW=true
SPACESHIP_KUBECTL_PREFIX='using '
SPACESHIP_KUBECTL_SYMBOL=''
SPACESHIP_KUBECTL_VERSION_SHOW=false

# brew installed binary
if [[ $(uname -m) -eq "arm64" ]]
then
    export PATH=/opt/homebrew/bin:$PATH
    export PATH=/opt/homebrew/sbin:$PATH
fi

# brew installed completion
if type brew &>/dev/null
then
    FPATH=$FPATH:$(brew --prefix)/share/zsh/site-functions
    autoload -Uz compinit
    compinit
fi

source $ZSH/oh-my-zsh.sh

# cargo binary
export PATH=$HOME/.cargo/bin:$PATH
# carg ENV
source $HOME/.cargo/env

# brew installed openssl
export PATH=$(brew --prefix openssl)/bin:$PATH

# zsh quick command
alias zshrc="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias szsh="source ~/.zshrc"

# general alias
alias grep='rg' # replace grep with rg
alias vim=nvim
alias vi=nvim
alias lh="ll -h"
if [ $TERM_PROGRAM ]
then
    echo "in $TERM_PROGRAM"
fi

if [ "$TERM_PROGRAM" = "iTerm.app" ]
then
    alias ls="lsd"
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='code'
else
    export EDITOR='vim'
fi

# date alias
alias yesterday='gdate --date="yesterday" +"%Y-%m-%d"'
alias today='gdate +"%Y-%m-%d"'
alias tomorrow='gdate --date="tomorrow" +"%Y-%m-%d"'

# git alias
function gittoday() {
    git log --since==$(yesterday) --until=$(today) --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1-$2} END {printf "added %s lines, removed %s lines, total: %s\n", add, subs, loc }' -
}

# gitignore tool
function gi() {
    curl -L -s https://www.gitignore.io/api/$@;
}
function gil() {
    curl -L -s https://www.gitignore.io/api/list
}

# docker alias
alias dockerkillall='docker kill $(docker ps -q)'
alias dockercleanc='printf "\n>>> Deleting stopped containersn\n" && docker ps -a -q | xargs docker rm -f'
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker images -q -f dangling=true | xargs docker rmi'
alias dockerclean='dockercleanc && dockercleani'
alias dockeri='docker images'
alias dockerp='docker ps'
alias dcc='dockercleanc'
alias dci='dockercleani'
alias dc='dockerclean'
alias di='docker images'
alias dp='docker ps'
alias dr='docker rm'
alias dri='docker rmi'
# docker get image entrypoint
alias dockerentrypoint="docker inspect -f '{{.Config.Entrypoint}}'"

# GO ENV config
export GOPATH=$HOME/gopath
export GOBIN=$GOPATH/bin
export GOROOT="$(brew --prefix golang)/libexec"
export GOCACHE=$HOME/.cache/go
export PATH=$GOPATH/bin$PATH
export GOPROXY=https://goproxy.io,direct
export GO111MODULE=on

# Rust config
alias rustdoc="rustup doc --toolchain=stable-x86_64-apple-darwin"

# Openresty&lua config
export PATH=$(brew --prefix openresty)/luajit/bin:$PATH

export KUBECONFIG="$HOME/Documents/Develop/kubeconfig/config.yaml"
# kubectl alias
alias k='kubectl'
alias kn='kubens'
alias kx='kubectx'
alias kexec='k exec -it'
alias kg='k get'
alias kgl='k get --show-labels'
alias kgw='k get -owide'
alias kgj='k get -ojson'
alias kgy='k get -oyaml'
alias kgp='kg pod'
alias kl='k logs'
alias kd='k describe'
alias kdel='k delete'
alias ktaint='kg node -o=jsonpath="{.spec.taints}"'
alias exportkube="kubectl config view --minify --raw" # export current kubeconfig
alias nodetaints='kubectl get node -o=jsonpath="{range .items[*]}{.metadata.name}{\"\t\"}{.spec.taints}{\"\n\"}{end}"'
alias nodedrain='kubectl drain --delete-emptydir-data  --ignore-daemonsets'
alias nodecapacity='kubectl get node -o=jsonpath="{range .items[*]}{.metadata.name}{\"\t\"}CPU: {.status.capacity.cpu}{\"\t\"}MEM: {.status.capacity.memory}{\"\t\"}PODS: {.status.capacity.pods}{\"\n\"}{end}"'
# krew plugin binary
alias krew='k krew'
export PATH=${KREW_ROOT:-$HOME/.krew}/bin:$PATH

export KUBE_EDITOR='code --wait'

function clearevict() {
    kubectl get pod -A | grep Evicted | awk '{printf "kubectl delete pod %s -n %s\n", $2, $1}' | bash
}

function netshoot() {
    kubectl get pod netshoot -n default --ignore-not-found=true | grep -v netshoot > /dev/null
    pod_not_exist=$?
    if [ $pod_not_exist = 0 ]; then
        kubectl attach -n default netshoot --pod-running-timeout=30s -it
    else
        kubectl run -n default netshoot -it --image=docker.libcuda.so/nicolaka/netshoot -- bash
    fi
}

function clean_netshoot() {
    kubectl delete pod netshoot -n default --force
}

function aws-exec() {
    profile="${1:-snc-test}"
    echo $profile
    if [ -z ${AWS_VAULT} ];
    then
        echo "AWS_VAULT is not set"
    else
        echo "AWS_VAULT is set"
        unset AWS_VAULT
    fi
    aws-vault exec $profile
}

alias snc-test="aws-exec snc-test"
alias snc-stage="aws-exec snc-stage"
alias snc-prod="aws-exec snc-prod"
alias snc-support="aws-exec snc-support"
alias snc-eng="aws-exec snc-eng"
alias sn-cloud-prod="aws-exec sn-cloud-prod"
alias snc="aws-exec snc"
alias cs-admin="aws-exec cs-admin"

# add pyenv shims to PATH
export PATH=$(pyenv root)/shims:${PATH}

# uuid
alias uuid="python -c 'import uuid;print(\"\".join(str(uuid.uuid4()).split(\"-\")).lower())'"

# cnpm
alias cnpm="npm --registry=https://registry.npm.taobao.org \
--cache=$HOME/.npm/.cache/cnpm \
--disturl=https://npm.taobao.org/dist \
--userconfig=$HOME/.cnpmrc"

# default ssh private key
export SSH_KEY_PATH="~/.ssh/rsa_id"

# numfmt
alias numfmt='gnumfmt'

function fix_broken_app() {
    sudo xattr -d com.apple.quarantine $1
}

# helix config
export HELIX_RUNTIME=$HOME/.config/helix/runtime
export HELIX_CONFIG=$HOME/.config/helix

# npm without proxy
function npm() {
    unset http_proxy unset https_proxy
    $(brew --prefix)/bin/npm $@
}

# enable gcloud cli
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# https://coderwall.com/p/jpj_6q/zsh-better-history-searching-with-arrow-keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down


# source ~/custom.zsh
source ~/secret.zsh
export PATH=~/scripts:$PATH


# docker version manager
# source dvm
[ -f /opt/homebrew/opt/dvm/dvm.sh ] && . /opt/homebrew/opt/dvm/dvm.sh
#dvm use 20.10.6
dvm use 20.10.11

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


# profiling
if [ "$PROFILING" ]
then
    zprof
fi