set fish_greeting

set PATH ~/.nix-profile/bin ~/.cargo/bin $PATH
set EDITOR ~/.nix-profile/bin/hx

if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init fish --disable-up-arrow | source
    broot --print-shell-function fish | source
    starship init fish | source
end

zoxide init fish | source
