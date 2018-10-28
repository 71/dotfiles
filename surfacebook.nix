# Configuration used for my Surface Book.
#
# It contains some kernel patches, necessary for a good Linux experience.
{ config, pkgs, ... }:

{
  imports = [ ./portable.nix ];

  # Kernel configuration.
  boot.kernelModules = [ "hid-multitouch" ];
  boot.initrd.kernelModules = [ "hid-multitouch" ];

  services.logind.extraConfig = ''
    HandlePowerKey=suspend
    HandleLidSwitch=ignore
  '';

  boot.kernelPackages = pkgs.linuxPackages_4_18;

  nixpkgs.config.packageOverrides = pkgs: {
    linux_4_18 = pkgs.linux_4_18.override {
      kernelPatches =
        # Load all patches in ./patches
        let files = builtins.attrNames (builtins.readDir ./patches); in
        map
          (x: { patch = "${./patches}/${x}"; name = builtins.replaceStrings [".patch"] [""] x; })
          (builtins.filter (x: null != builtins.match ".+\\.patch" x) files)
        ;
    };
  };

  # Enable audio and bluetooth.
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  # Use AZERTY layout and adapt to high screen resolution.
  services.xserver = {
    layout = "fr";
    xkbOptions = "eurosign:e";

    monitorSection = ''
      DisplaySize 396 264
    '';
  };
}
