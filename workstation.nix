{ config, pkgs, ... }:

{
  imports = [ ./common-portable.nix ];

  environment.systemPackages = [ pkgs.xorg.xkbcomp ];

  services.xserver.displayManager.sessionCommands =
    "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${./misc/yath.xkb} $DISPLAY";
}
