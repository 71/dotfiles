# Configuration for my desktop.
#
# I use my own keyboard layout, and it's used here.
{ config, pkgs, ... }:

{
  imports = [ ./portable.nix ];

  environment.systemPackages = [
    pkgs.xorg.xkbcomp
  ];

  # Use YATH keyboard layout.
  services.xserver.displayManager.sessionCommands =
    "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${./misc/yath.xkb} $DISPLAY";
}

