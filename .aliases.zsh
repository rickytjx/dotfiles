#!/bin/zsh

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias ls='ls -G'
if [[ $(uname) != "Darwin" ]]
then
  alias ls='ls --color=auto'
fi
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

alias grep="grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}"

alias sf="docker-compose exec php bin/console"
alias dc="docker-compose exec php composer"

# WSL specific things
if grep --quiet microsoft /proc/version 2>/dev/null; then
  alias idea="(pkill -f 'java.*idea' || true) && screen -d -m /opt/idea/bin/idea.sh"
  alias wslb="PowerShell.exe 'Start-Process PowerShell -Verb RunAs \"PowerShell -File \$env:USERPROFILE\\wsl2-bridge.ps1\"'"
  alias dcs="sudo /etc/init.d/docker start"
fi

# -------------------------------- #
# Node Package Manager
# -------------------------------- #
# https://github.com/antfu/ni

alias nio="ni --prefer-offline"
alias s="nr start"
alias d="nr dev"
alias b="nr build"
alias bw="nr build --watch"
alias t="nr test"
alias tu="nr test -u"
alias tw="nr test --watch"
alias w="nr watch"
alias p="nr play"
alias c="nr typecheck"
alias lint="nr lint"
alias lintf="nr lint --fix"
alias release="nr release"
alias re="nr release"

# -------------------------------- #
# Git
# -------------------------------- #

# Use github/hub
alias git=hub

# Go to project root
alias grt='cd "$(git rev-parse --show-toplevel)"'

alias gs='git status'
alias gp='git push'
alias gpf='git push --force'
alias gpft='git push --follow-tags'
alias gpl='git pull --rebase'
alias gcl='git clone'
alias gst='git stash'
alias grm='git rm'
alias gmv='git mv'

alias main='git checkout main'

alias gco='git checkout'
alias gcob='git checkout -b'

alias gb='git branch'
alias gbd='git branch -d'

alias grb='git rebase'
alias grbom='git rebase origin/master'
alias grbc='git rebase --continue'

alias gl='git log'
alias glo='git log --oneline --graph'

alias grh='git reset HEAD'
alias grh1='git reset HEAD~1'

alias ga='git add'
alias gA='git add -A'

alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit -a'
alias gcam='git add -A && git commit -m'
alias gfrb='git fetch origin && git rebase origin/master'

alias gxn='git clean -dn'
alias gx='git clean -df'

alias gsha='git rev-parse HEAD | pbcopy'

alias ghci='gh run list -L 1'

function glp() {
  git --no-pager log -$1
}

function gd() {
  if [[ -z $1 ]] then
    git diff --color | diff-so-fancy
  else
    git diff --color $1 | diff-so-fancy
  fi
}

function gdc() {
  if [[ -z $1 ]] then
    git diff --color --cached | diff-so-fancy
  else
    git diff --color --cached $1 | diff-so-fancy
  fi
}

# -------------------------------- #
# Directories
#
# I put
# `~/i` for my projects
# `~/f` for forks
# `~/r` for reproductions
# -------------------------------- #

function i() {
  cd ~/dev/workspaces/me/$1
}

function repros() {
  cd ~/dev/workspaces/reproductions/$1
}

function forks() {
  cd ~/dev/workspaces/forks/$1
}

function pufa() {
  cd ~/dev/workspaces/pufa/$1
}

function pr() {
  if [ $1 = "ls" ]; then
    gh pr list
  else
    gh pr checkout $1
  fi
}

function dir() {
  mkdir $1 && cd $1
}

function clone() {
  if [[ -z $2 ]] then
    hub clone "$@" && cd "$(basename "$1" .git)"
  else
    hub clone "$@" && cd "$2"
  fi
}

# Clone to ~/i and cd to it
function clonei() {
  i && clone "$@" && code . && cd ~2
}

function cloner() {
  repros && clone "$@" && code . && cd ~2
}

function clonef() {
  forks && clone "$@" && code . && cd ~2
}

function clonep() {
  pufa && clone "$@" && code . && cd ~2
}

function codei() {
  i && code "$@" && cd -
}

function codep() {
  pufa && code "$@" && cd -
}

function serve() {
  if [[ -z $1 ]] then
    live-server dist
  else
    live-server $1
  fi
}
