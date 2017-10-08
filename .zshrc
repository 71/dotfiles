# Path to my oh-my-zsh installation:
export ZSH=/root/.oh-my-zsh

# Load some default .files:
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  source "${rcfile}"
done

# Plugins:
plugins=(git)

# ZSH config:
source $ZSH/oh-my-zsh.sh

ZSH_THEME="robbyrussell"
PURE_PROMPT_SYMBOL="λ"
prompt pure

# Miscellaneous config:
export EDITOR='emacs'
export DISPLAY=:0
export PATH=$PATH:/mnt/c/Windows/System32

alias config='/usr/bin/git --git-dir=/root/.cfg/ --work-tree=/root'

source $HOME/.profile
source $HOME/.machine

\cp -rf $SSH_SHARED_DIR $HOME
chmod 600 $HOME/.ssh/id_rsa
chmod 600 $HOME/.ssh/id_rsa.pub
