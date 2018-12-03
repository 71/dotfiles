{ pkgs, ... }:

{
  home.packages = with pkgs; [
    man

    (ghc.withPackages (hpkgs: with hpkgs; [ xmonad xmonad-contrib ]))
  ];

  # Enable home-manager
  programs.home-manager.enable = true;
  programs.home-manager.path = https://github.com/rycee/home-manager/archive/master.tar.gz;
}
