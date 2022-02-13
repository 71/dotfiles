{ config, pkgs, ... }:

{
  imports = [
    ../modules/core.nix
    ../modules/desktop-environment.nix
    ../modules/persistence.nix
    ../modules/secrets.nix
    ../modules/users.nix
  ];

  # Hardware.
  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;

    bluetooth.enable = true;
    video.hidpi.enable = true;

    cpu.intel.updateMicrocode = true;
  };

  # Networking.
  networking.interfaces.wlp3s0.useDHCP = true;

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = false;

      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";

      grub = {
        enable = true;
        version = 2;
        efiSupport = true;
        devices = ["nodev"];
        useOSProber = true;
      };
    };

    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ "wl" ];
    };

    kernelParams = [ "nohibernate" ];
    kernelModules = [ "kvm-intel" "wl" ];
    extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  };

  # ZFS.
  boot = {
    supportedFilesystems = [ "zfs" ];

    zfs = {
      enableUnstable = true;
      requestEncryptionCredentials = true;
      devNodes = "/dev/";
    };

    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  };

  services = {
    zfs = {
      trim.enable = true;
      autoScrub.enable = true;
      autoScrub.pools = [ "rpool" ];
    };
  };

  # File system.
  fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=2G" "mode=755" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/75A8-86C9";
      fsType = "vfat";
      options = [ "X-mount.mkdir" ];
    };

  fileSystems."/nix" =
    { device = "rpool/system/nix";
      fsType = "zfs";
      options = [ "zfsutil" ];
      neededForBoot = true;
    };

  fileSystems."/nix/state" =
    { device = "rpool/data/state";
      fsType = "zfs";
      neededForBoot = true;
    };

  fileSystems."/home" =
    { device = "rpool/data/home";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };

  fileSystems."/home/g" =
    { device = "rpool/data/home/g";
      fsType = "zfs";
      options = [ "zfsutil" ];
      # neededForBoot = true;  # By `agenix`.
    };

  fileSystems."/root" =
    { device = "rpool/data/home/root";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };

  swapDevices = [
    { device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S4EWNX0R152969R-part2";
      randomEncryption = true;
    }
  ];

  # Other.
  powerManagement.cpuFreqGovernor = "performance";
}
