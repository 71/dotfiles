# Path to my oh-my-zsh installation:
export ZSH=$HOME/.oh-my-zsh

# Load some default .files:
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  source "${rcfile}"
done

# Plugins:
plugins=(git fast-syntax-highlighting thefuck)

# ZSH config:
source $ZSH/oh-my-zsh.sh

ZSH_THEME=""
PURE_PROMPT_SYMBOL="λ"

# Miscellaneous config:
export EDITOR='nvim'

alias config='/usr/bin/git --git-dir=/root/.cfg/ --work-tree=/root'
alias v='nvim'
alias nv='nvim'
alias vim='nvim'
alias zqsd='setxkbmap sp'
alias yath='setxkbmap fr'

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
zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure


eval $(thefuck --alias)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
