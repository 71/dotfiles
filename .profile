# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true

export PATH="$HOME/.cargo/bin:$HOME/.nimble/bin:/usr/etc/nim/bin:$PATH"
source ~/.cargo/env

# OPAM configuration
. /root/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
