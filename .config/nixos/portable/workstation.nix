# Configuration for my desktop.
#
# I use my own keyboard layout, and it's used here.

{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.xorg.xkbcomp pkgs.xorg.setxkbmap
  ];

  environment.shellAliases = {
    zqsd = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${../misc/yath.xkb} $DISPLAY";
    yath = "${pkgs.xorg.setxkbmap}/bin/setxkbmap fr";
  };

  services.xserver = {
    # Use YATH keyboard layout.
    displayManager.setupCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${../misc/yath.xkb} $DISPLAY";
  };
}

