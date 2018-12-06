# Configuration common to every device I have, intended to by light,
# but to have every tool I use on a daily basis.

{ config, lib, pkgs, ... }:

{
  # ===========================================================================
  # == PACKAGES ===============================================================
  # ===========================================================================

  environment.systemPackages = with pkgs; [
    # Essential.
    antibody curl exa fzf git man neovim nnn ripgrep wget zsh

    # Git tools
    git-crypt gitAndTools.grv gitAndTools.diff-so-fancy

    # Python & co.
    (python3.withPackages (pypkgs: [ pypkgs.neovim pypkgs.pygments ]))
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

    FZF_DEFAULT_OPTS = ''
      --preview '[[ \$(file --mime {}) =~ binary ]] && \
                    echo {} is a binary file || \
                    (head -200 {} | pygmentize -s -l \$(pygmentize -N {}))'
    '';
    FZF_DEFAULT_COMMAND = "git ls-files || find";
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

