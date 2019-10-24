# Configuration common to every device I have, intended to by light,
# but to have every tool I use on a daily basis.

{ config, lib, pkgs, ... }:

let
  nixosVersion = "19.09";

  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "f856c78a4a220f44b64ce5045f228cbb9d4d9f31";
    ref = "release-${nixosVersion}";
  };
in
{
  # ===========================================================================
  # == HOME MANAGER ===========================================================
  # ===========================================================================

  imports = [
    "${home-manager}/nixos"
  ];


  # ===========================================================================
  # == PACKAGES ===============================================================
  # ===========================================================================

  environment.systemPackages = with pkgs; [
    # Essential
    antibody curl exa fzf git kakoune man neovim nnn ripgrep wget zsh

    # Git tools
    git-crypt gitAndTools.grv gitAndTools.diff-so-fancy

    # Python
    python3
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

    ls = "exa";
    grep = "ripgrep";
  };

  environment.variables = {
    EDITOR   = "nvim";
    SHELL    = "zsh";

    FZF_DEFAULT_COMMAND = "git ls-files || find";
    FZF_DEFAULT_OPTS = ''
      --preview '[[ \$(file --mime {}) =~ binary ]] && \
                    echo {} is a binary file || \
                    (head -200 {} | pygmentize -s -l \$(pygmentize -N {}))'
    '';
  };

  environment.sessionVariables = {
    NIX_PATH = lib.mkAfter [ "nixpkgs-overlays=${./overlays}" ];
  };


  # ===========================================================================
  # == PROGRAMS ===============================================================
  # ===========================================================================

  programs = {
    zsh.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;


  # ===========================================================================
  # == SYSTEM =================================================================
  # ===========================================================================

  # Time zone
  time.timeZone = "Europe/Paris";

  # Nix things
  system.stateVersion = nixosVersion;

  nixpkgs.config = {
    allowUnfree = true;
  };

  # Security
  security.sudo.wheelNeedsPassword = false;
}
