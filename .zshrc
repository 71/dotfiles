# Path to my oh-my-zsh installation:
export ZSH=/root/.oh-my-zsh

# Load some default .files:
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  source "${rcfile}"
done

# Plugins:
plugins=(git fast-syntax-highlighting thefuck)

# ZSH config:
source $ZSH/oh-my-zsh.sh

ZSH_THEME="robbyrussell"
PURE_PROMPT_SYMBOL="λ"
prompt pure

# Miscellaneous config:
export EDITOR='nvim'

alias config='/usr/bin/git --git-dir=/root/.cfg/ --work-tree=/root'
alias nv='nvim'
alias vim='nvim'

source $HOME/.profile
source $HOME/.machine

\cp -rf $SSH_SHARED_DIR $HOME
chmod 600 $HOME/.ssh/id_rsa
chmod 600 $HOME/.ssh/id_rsa.pub

### Load zplugin
source '/root/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

# Plugins
zplugin load zdharma/fast-syntax-highlighting
