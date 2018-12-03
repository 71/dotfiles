# Configuration common to every device I have, intended to by light,
# but to have every tool I use on a daily basis.

{ config, lib, pkgs, ... }:

{
  # ===========================================================================
  # == PACKAGES ===============================================================
  # ===========================================================================

  environment.systemPackages = with pkgs; [
    # Essential.
    antibody curl exa fzf git git-crypt man neovim nnn wget zsh

    # Python & co.
    (python3.withPackages (pypkgs: [ pypkgs.neovim ]))
  ];


  # ===========================================================================
  # == ENVIRONMENT ============================================================
  # ===========================================================================

  environment.shellAliases = {
    # Ensures all aliases after 'sudo' are expanded as well
    sudo = "sudo ";

    g    = "git";
    v    = "nvim";
    vc   = "nvim /etc/nixos/config";

    ne   = "nix-env";
    nr   = "nix repl";
    ns   = "nix-shell";
    nxsw = "nixos-rebuild switch";
  };

  environment.variables = {
    EDITOR   = "nvim";
    SHELL    = "zsh";
  };

  environment.sessionVariables = {
    NIX_PATH = lib.mkAfter [ "nixpkgs-overlays=/etc/nixos/config/overlays" ];
  };


  # ===========================================================================
  # == PROGRAMS ===============================================================
  # ===========================================================================

  programs = {
    zsh.enable = true;
  };


  # ===========================================================================
  # == SYSTEM =================================================================
  # ===========================================================================

  security.sudo.wheelNeedsPassword = false;

  # Only change this if the release notes tell us to do so.
  system.stateVersion = "18.09";
}

