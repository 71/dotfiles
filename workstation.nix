# Configuration for my desktop.
#
# I use my own keyboard layout, and it's used here.

{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.xorg.xkbcomp
  ];

  services.xserver = {
    # Use YATH keyboard layout.
    displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${./misc/yath.xkb} $DISPLAY";
  };
}

