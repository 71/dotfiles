# Configuration common to every device I have, intended to by light,
# but to have every tool I use on a daily basis.

{ config, lib, pkgs, ... }:

{
  # ===========================================================================
  # == PACKAGES ===============================================================
  # ===========================================================================

  environment.systemPackages = with pkgs; [
    # Python & co.
    (python3.withPackages (pyPkgs: [ pyPkgs.neovim ]))

    # Misc.
    antibody curl lf git neovim wget zsh
  ];


  # ===========================================================================
  # == ENVIRONMENT ============================================================
  # ===========================================================================

  environment.shellAliases = {
    g    = "git";
    v    = "nvim";
    vc   = "nvim /etc/nixos/config";

    groot = "git --git-dir=/etc/nixos/config/.git --work-tree=/etc/nixos/config";
    guser = "git --git-dir=$HOME/.git --work-tree=$HOME";

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
  # == SERVICES ===============================================================
  # ===========================================================================


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

