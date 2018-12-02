
# Antibody
# ========

source <(antibody init)

antibody bundle robbyrussell/oh-my-zsh folder:plugins/git
antibody bundle robbyrussell/oh-my-zsh folder:plugins/git-extras
antibody bundle robbyrussell/oh-my-zsh folder:plugins/thefuck
antibody bundle rupa/z
antibody bundle spwhitt/nix-zsh-completions
antibody bundle chisui/zsh-nix-shell

antibody bundle denysdovhan/spaceship-prompt

antibody bundle zsh-users/zsh-autosuggestions
antibody bundle zsh-users/zsh-completions
antibody bundle zsh-users/zsh-syntax-highlighting


# Customization
# =============

# ZSH options
#
setopt HIST_FIND_NO_DUPS

# Spaceship options
#
spaceship_vi_mode_enable

SPACESHIP_VI_MODE_COLOR='#007'
SPACESHIP_VI_MODE_INSERT='\uE0B3'
SPACESHIP_VI_MODE_NORMAL='\uE0B1'

SPACESHIP_DIR_TRUNC=0
SPACESHIP_DIR_TRUNC_REPO=false

spaceship_nix_shell() {
  [[ $IN_NIX_SHELL ]] || return

  spaceship::section  \
    "#007"          \
    "in "             \
    "nix shell"       \
    "$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
}

SPACESHIP_PROMPT_ORDER=(time user dir host git rust nix_shell exec_time line_sep battery jobs exit_code char)
SPACESHIP_RPROMPT_ORDER=(vi_mode)

