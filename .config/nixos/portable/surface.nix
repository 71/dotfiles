# Configuration used for my Surface Book.
#
# It contains some kernel patches, necessary for a good Linux experience.
{ config, pkgs, ... }:

{
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
        # Patches are from https://github.com/jakeday/linux-surface
        let files = builtins.attrNames (builtins.readDir ./surface-patches); in
        map
          (x: { patch = "${./surface-patches}/${x}"; name = builtins.replaceStrings [".patch"] [""] x; })
          (builtins.filter (x: null != builtins.match ".+\\.patch" x) files)
        ;
    };
  };

  # Enable audio and bluetooth.
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  # Use AZERTY layout and adapt to high screen resolution.
  services.xserver = {
    monitorSection = ''
      DisplaySize 396 264
    '';
  };
}
