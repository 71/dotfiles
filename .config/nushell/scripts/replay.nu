# Executes the given command in `bash` and returns a record similar to `$env`
# corresponding to the environment in `bash` at the end of its execution.
export def play [...args: string] {
  let pipe_name = (^mktemp --tmpdir --dry-run 'replay-nu-XXXXXXXXXX' | str trim)

  ^bash -c $"
    ($args | flatten | str collect ' ')

    env > ($pipe_name)
  "

  let exit_code = $env.LAST_EXIT_CODE

  if $exit_code != 0 {
    exit $exit_code
  }

  cat $pipe_name | lines | parse '{key}={value}' | transpose -r | first
}

# Returns a subset of `new_env` where entries already in `$env` are filtered
# out.
export def diff [new_env: any] {
  $new_env
  | transpose key value
  | where key not-in $env || value != ($env | get $it.key)
  | transpose -r
  | first
  | reject _ SHLVL
}

# Updates `$env` to match the environment resulting from running the given
# command in `bash`.
#
# Example:
#   > replay (ssh-agent)
export def-env replay [...args: string] {
  diff (play $args) | load-env
}
