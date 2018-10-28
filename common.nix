# Configuration common to every device I have, intended to by light,
# but to have every tool I use on a daily basis.

{ config, pkgs, ... }:

{
  # ===========================================================================
  # == PACKAGES ===============================================================
  # ===========================================================================

  environment.systemPackages = with pkgs; [
    # Python & co.
    (python3.withPackages (pyPkgs: [ pyPkgs.neovim ]))

    # Misc.
    curl lf git neovim wget zsh
  ];


  # ===========================================================================
  # == ENVIRONMENT ============================================================
  # ===========================================================================

  environment.shellAliases = {
    g    = "git";
    gs   = "git status";
    gl   = "git pull";
    gp   = "git push";
    v    = "nvim";
    vc   = "nvim /etc/nixos/config";

    groot = "git --git-dir=/etc/nixos/config/.git --work-tree=/etc/nixos/config";
    guser = "git --git-dir=$HOME/.cfg --work-tree=$HOME";

    ne   = "nix-env";
    nr   = "nix repl";
    ns   = "nix-shell";
    nxsw = "nixos-rebuild switch";
  };

  environment.variables = {
    EDITOR   = "nvim";
    SHELL    = "zsh";
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

  # Only change this if the release notes tell us to do so.
  system.stateVersion = "18.09";
}

