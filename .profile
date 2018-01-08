# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true

# Path setup
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/termite:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.nimble/bin:/usr/etc/nim/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"

# Environment variables
export TERM="xterm-256color"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib"

# Source config files
. ~/.cargo/env # Rust / Cargo
. ~/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true # OCaml / Opam
. ~/.z.sh # Z

