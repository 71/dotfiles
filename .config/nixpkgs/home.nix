{ pkgs, ... }:

let
  nixos = builtins.pathExists /etc/nixos/configuration.nix;

  core = ./system.nix ../nixos/common.nix;
in
{
  # Packages
  home.packages = with pkgs; [
    man

    (ghc.withPackages (hpkgs: with hpkgs; [ xmonad xmonad-contrib ]))
  ];

  # Git
  programs.git = core.programs.git;

  # Enable home-manager
  programs.home-manager.enable = true;
  programs.home-manager.path = https://github.com/rycee/home-manager/archive/master.tar.gz;
}
