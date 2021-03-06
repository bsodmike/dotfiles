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
plugins=(git bundler brew gem)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/share/python:/usr/local/go/bin:/usr/local/share/npm/bin:/usr/local/CrossPack-AVR/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# Golang workspace
export GOROOT=/usr/local/go
export GOPATH=$HOME/gocode
export PATH=$PATH:$HOME/gocode/bin

# User specific environment and startup programs
function crc32 { cksum -o3 "$@"|ruby -e 'STDIN.each{|a|a=a.split;printf "%08X\t%s\n",a[0],a[2..-1].join(" ")}'; }

# slows down terminal spawning for python virtualenv
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/share/python/virtualenvwrapper.sh

# disable for rbenv
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
eval "$(rbenv init -)"
