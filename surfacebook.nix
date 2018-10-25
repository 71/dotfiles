{ config, pkgs, ... }:

{
  imports = [ ./common-portable.nix ];

  boot.kernelModules = [ "hid-multitouch" ];
  boot.initrd.kernelModules = [ "hid-multitouch" ];

  services.logind.extraConfig = ''
    HandlePowerKey=suspend
    HandleLidSwitch=ignore
  '';

  boot.kernelPackages = pkgs.linuxPackages_4_17;

  nixpkgs.config.packageOverrides = pkgs: {
    linux_4_17 = pkgs.linux_4_17.override {
      kernelPatches =
        let files = map
          (builtins.attrNames)
          (builtins.readDir (path: type: type == "regular") ./patches); in
        map
          (x: { patch = x; name = builtins.baseNameOf x; })
          (builtins.filter (builtins.match ".+\\.patch"))
        ;
    };
  };

  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  services.xserver = {
    layout = "fr";
    xkbOptions = "eurosign:e";

    monitorSection = ''
      DisplaySize 396 264
    '';
  };
}
