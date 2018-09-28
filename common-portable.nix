{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  # Portable configuration
  networking.hostName = "Primrose";


  # Hardware configuration
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "uas" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/4c781a19-b376-4a10-8be6-a9341b43b736";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/20E5-F176";
      fsType = "vfat";
    };

  swapDevices = [
    # { device = "/dev/disk/by-uuid/7cb9081e-9860-4b4e-8404-23f2f08f3c5c"; }
  ];

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
