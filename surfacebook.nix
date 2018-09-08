{ config, pkgs, ... }:

{
  imports = [ ./common-portable.nix ];

  services.xserver = {
    layout = "fr";
    xkbOptions = "eurosign:e";

    monitorSection = ''
      DisplaySize 396 264
    '';
  };
}
