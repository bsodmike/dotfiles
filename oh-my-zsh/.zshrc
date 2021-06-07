#!/bin/zsh

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bsodmike"

# Set MacVim as default editor
export EDITOR=mvim

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git bundler brew gem zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/share/npm/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/opt/mysql@5.7/bin:/Users/mdesilva/Library/Android/sdk/tools:/Users/mdesilva/Library/Android/sdk/platform-tools

# User specific environment and startup programs
function crc32 { cksum -o3 "$@"|ruby -e 'STDIN.each{|a|a=a.split;printf "%08X\t%s\n",a[0],a[2..-1].join(" ")}'; }

# slows down terminal spawning
# for python virtualenv
#export WORKON_HOME=$HOME/.virtualenvs
#export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
#source /usr/local/bin/virtualenvwrapper.sh

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# For AWS CLI zsh completion:
source /usr/local/share/zsh/site-functions/_aws

greet="Hi Mike... How are you today?"
fortune | cowsay | lolcat

echo "\n$greet\n"

# Load bash exports
[[ -f $HOME/.zsh_exports ]] && . $HOME/.zsh_exports
[[ -f $HOME/.aws_exports ]] && . $HOME/.aws_exports

echo ""

keys=(
  "id_rsa_m6as@securecloudsolutions.io_pk00_18032018"
  "id_ed25519_mike.cto@securecloudsolutions.io_07JUN2021"
  "id_rsa_primary_23072016"
)
for i in "${keys[@]}"
do
  echo "### Loading SSH key: $i"
  eval "$(ssh-add $HOME/.ssh/$i)"
done

echo ""

# GPG
export GPG_TTY=$(tty)

# Node Version Manager
export NVM_DIR="/Users/mdesilva/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Python
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
export PATH="$HOME/Library/Python/3.8/bin:$PATH"
alias python=/usr/local/opt/python@3.8/bin/python3
alias pip=/usr/local/opt/python@3.8/bin/pip3

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
source $HOME/.cargo/env

# Redis
export PATH="/usr/local/Cellar/redis/5.0.9/bin:$PATH"

# chromedriver
export PATH="$HOME/WebDriver/bin:$PATH"

# Shell Conveniences
alias rbenv_upgrade="brew update && brew upgrade rbenv ruby-build"
alias vim_conflict="mvim \`git status|grep 'both modified'|cut -d: -f2\`"
git_co() { git checkout $(git branch | cut -c 3- | pick) }
git_stash_apply() { git stash apply $(git stash list | pick | awk 'NR==1{printf $1}' | cut -d : -f 1,3) }
alias today="\`(date +"%d%m%Y")\`"
alias pwdcopy="pwd | pbcopy"
alias pad="mvim ~/inertialbox/pad.md"

alias gri="git rebase -i -S --autosquash"
alias grc="git rebase --continue"
alias gfix="git commit --fixup"
alias gpub="git pub"
alias gfm="git checkout master && git fetch origin && git pull"
#alias gitstats="f() { git log --author=$1 --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf \"added lines: %s, removed lines: %s, total lines: %s\n\", add, subs, loc }' - }; f"

alias mbp-mike-ip="dig @10.0.0.1 mbp-mike +short"
alias skylake-server-ip="dig @10.0.0.1 skylake-server.intranet +short"

alias pi0="ssh mdesilva@pi0"
alias freenas-primary="ssh root@\`dig freenas-primary.intranet +short\`"

alias copy-ssh-keys-to-mbp="scp -r /Users/mdesilva/.ssh/* \`mbp-mike-ip\`:~/.ssh"
alias sync-nanomag-to-mbp="rsync -avzP -e \"ssh -i /Users/mdesilva/.ssh/id_rsa_primary_23072016\" . \`mbp-mike-ip\`:~/work/nanomag-mbp"
alias backup-inertialbox="sudo rsync -avzP /Volumes/inertialbox \"/Volumes/WD Black Backup 1/Backup, 20th July 2017/\""

# WS
server() { ag $1 /Volumes/inertialbox/clients/whitespace/whitespace-chef-repo/nodes/* | sed 's/.*\/\(vhost[^.]*\).*app-\([^]]*\)]"[,]*/\2:\1/' }
kick() { ssh vhost$1 -l root -t 'killall -USR1 chef-client && tail -f -n1000 /var/log/chef/client.log' }


