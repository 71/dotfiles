# Include private bin if it exists
if [ -d "$HOME/bin" ]; then PATH="$HOME/bin:$PATH"; fi
if [ -d "$HOME/.local/bin" ]; then PATH="$HOME/.local/bin:$PATH"; fi

# Load Nix environment
for f in nix hm-session-vars
do
  if [ -e $HOME/.nix-profile/etc/profile.d/$f.sh ]; then . $HOME/.nix-profile/etc/profile.d/$f.sh; fi
done

# Load aliases
if [ -e $HOME/.aliases ]; then . $HOME/.aliases; fi
