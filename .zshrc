
# Antigen
# =======

source <(antibody init)

antibody bundle robbyrussell/oh-my-zsh folder:plugins/git
antibody bundle robbyrussell/oh-my-zsh folder:plugins/git-extras
antibody bundle robbyrussell/oh-my-zsh folder:plugins/thefuck
antibody bundle rupa/z

antibody bundle denysdovhan/spaceship-prompt

antibody bundle zsh-users/zsh-autosuggestions
antibody bundle zsh-users/zsh-completions
antibody bundle zsh-users/zsh-syntax-highlighting

# Customization
# =============

setopt HIST_FIND_NO_DUPS

