#!/bin/zsh
# profiling
# zmodload zsh/zprof
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
    proxy
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

# zsh spaceship promt config
SPACESHIP_TIME_SHOW=true
SPACESHIP_KUBECTL_SHOW=true
SPACESHIP_KUBECTL_PREFIX='using '
SPACESHIP_KUBECTL_SYMBOL=''
SPACESHIP_KUBECTL_VERSION_SHOW=false

# brew installed completion
if type brew &>/dev/null
then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
fi

source $ZSH/oh-my-zsh.sh

SOCKS5_PROXY="http://127.0.0.1:1086"
HTTP_PROXY="http://127.0.0.1:1087"
ALL_PROXY="http://127.0.0.1:7890"

# cargo bi
export PATH="$HOME/.cargo/bin:$PATH"
# carg ENV
source $HOME/.cargo/env

# zsh quick command
alias zshrc="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias szsh="source ~/.zshrc"

# general alias
alias grep='rg' # replace grep with rg
alias vim=nvim
alias vi=nvim
alias lh="ll -h"
echo "in $TERM_PROGRAM"
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
function gi() { http_proxy=$HTTP_PROXY https_proxy=$HTTP_PROXY curl -L -s https://www.gitignore.io/api/$@; }
function gil() { http_proxy=$HTTP_PROXY https_proxy=$HTTP_PROXY curl -L -s https://www.gitignore.io/api/list }

# docker version manager
# source dvm
source ~/.dvm/dvm.sh
#dvm use 20.10.6
dvm use 20.10.11

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
export GOROOT="$(/opt/homebrew/bin/brew --prefix golang)/libexec"
export GOCACHE=$HOME/.cache/go
export PATH=$PATH:$GOPATH/bin
export GOPROXY=https://goproxy.io,direct
#export GOPRIVATE="gitlab.oneitfarm.com"
export GO111MODULE=on
export GONOSUMDB=gitlab.oneitfarm.com/*

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
alias nodecapacity='kubectl get node -o=jsonpath="{range .items[*]}{.metadata.name}{\"\t\"}CPU: {.status.capacity.cpu}{\"\t\"}MEM: {.status.capacity.memory}{\"\t\"}PODS: {.status.capacity.pods}{\"\n\"}{end}"'
# krew plugin binary
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

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
        kubectl run -n default netshoot -it --image=hub.oneitfarm.com/nicolaka/netshoot -- bash
    fi
}

function clean_netshoot() {
    kubectl delete pod netshoot -n default --force
}

# python3 as default python
alias python="python3"

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

# brew installed binary
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH

# helix config
export HELIX_RUNTIME=$HOME/.config/helix/runtime
export HELIX_CONFIG=$HOME/.config/helix

# npm without proxy
function npm() {
    unset http_proxy unset https_proxy
    /opt/homebrew/bin/npm $@
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# profiling
# zprof
# source ~/custom.zsh
source ~/secret.zsh
export PATH=~/scripts:$PATH