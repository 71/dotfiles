# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true

export PATH="$HOME/.cargo/bin:$HOME/.nimble/bin:/usr/etc/nim/bin:$HOME/termite:$PATH"
export TERM="xterm-256color"

# Source config files
. ~/.cargo/env # Rust / Cargo
. ~/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true # OCaml / Opam
. ~/.z.sh # Z

