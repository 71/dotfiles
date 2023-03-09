# Custom aliases.

export alias goto = g
export alias g = ^git-branchless wrap --


# Starship: `starship init nu`.

# Add a leading space for `--status` because negative exit codes break it.
export alias starship_prompt = ^starship prompt --cmd-duration $env.CMD_DURATION_MS --status ($env.LAST_EXIT_CODE | math abs)


# Zoxide: `zoxide init nushell --hook prompt`.

export def-env z [...rest:string] {
  # `z -` does not work yet, see https://github.com/nushell/nushell/issues/4769
  let arg0 = ($rest | append '~').0
  let path = if (($rest | length) <= 1) and ($arg0 == '-' or ($arg0 | path expand | path type) == dir) {
    $arg0
  } else {
    (zoxide query --exclude $env.PWD -- $rest | str trim -r -c "\n")
  }
  cd $path
}

# Jump to a directory using interactive search.
export def-env zi  [...rest:string] {
  cd $'(zoxide query -i -- $rest | str trim -r -c "\n")'
}

# Replay.
export use ../scripts/replay.nu

# Dynamic stuff.
export use ../.cache/dynamic.nu *


# Config.

# We have to put everything in a single `export-env` since Nushell discards
# all but the last `export-env`.

export-env {
  use ./config.nu

  # Prompt.
  let-env PROMPT_COMMAND = { starship_prompt }
  let-env PROMPT_COMMAND_RIGHT = { starship_prompt --right }

  let-env PROMPT_INDICATOR = { "" }
  let-env PROMPT_INDICATOR_VI_INSERT = { ": " }
  let-env PROMPT_INDICATOR_VI_NORMAL = { "〉" }
  let-env PROMPT_MULTILINE_INDICATOR = { "::: " }

  # Starship.
  let-env STARSHIP_SHELL = 'nu'
  let-env STARSHIP_SESSION_KEY = (random chars -l 16)

  # Zoxide.
  let-env config = ($env.config | update hooks.env_change.PWD ($env.config.hooks.env_change.PWD | append {|_, dir|
    ^zoxide add -- $dir
  }))
}
