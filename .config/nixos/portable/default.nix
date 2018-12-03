# Configuration used on my SSD, which is LUKS-encrypted.
#
# It is intended to be portable, but to have a complete
# desktop environment at the same time.

{ config, lib, pkgs, ... }:

let secrets = import ../secrets.nix; in
{
  # ===========================================================================
  # == PACKAGES ===============================================================
  # ===========================================================================

  environment.systemPackages = with pkgs; [
    alacritty firefox ncmpcpp onboard thefuck xclip
  ];


  # ===========================================================================
  # == ENVIRONMENT ============================================================
  # ===========================================================================

  environment.variables = {
    TERMINAL = "alacritty";
  };


  # ===========================================================================
  # == SERVICES ===============================================================
  # ===========================================================================

  services = {
    xserver = {
      enable = true;
      libinput.enable = true;

      layout = "fr,us";
      xkbOptions = "eurosign:e";

      autoRepeatDelay = 250;
      autoRepeatInterval = 25;

      desktopManager = {
        xterm.enable = false;

        default = "none";
      };

      windowManager = {
        i3 = {
          enable = true;
          package = pkgs.i3-gaps;
          extraPackages = [
            (pkgs.polybar.override { i3GapsSupport = true; mpdSupport = true; pulseSupport = true; })
            pkgs.rofi
          ];
        };

        default = "i3";
      };

      displayManager.lightdm = {
        background = "${./login-wallpaper.jpg}";

        greeters.gtk = {
          indicators = ["~a11y" "~layout" "~spacer" "~clock" "~spacer" "~power"];
          extraConfig = ''
            hide-user-image = true
            keyboard = ${pkgs.onboard}/bin/onboard
          '';
        };
      };
    };

    mopidy = {
      enable = true;
      extensionPackages = [ pkgs.mopidy-spotify ];
      configuration = ''
        [audio]
        output = pulsesink server=127.0.0.1

        [spotify]
        enabled = true
        username = ${secrets.spotify.username}
        password = ${secrets.spotify.password}
        client_id = ${secrets.spotify.clientId}
        client_secret = ${secrets.spotify.clientSecret}
        bitrate = 320

        [mpd]
        enabled = true
        hostname = 127.0.0.1
        port = 6600

        [http]
        enabled = false
      '';
    };
  };


  # ===========================================================================
  # == PROGRAMS & HARDWARE ====================================================
  # ===========================================================================

  programs = { };

  hardware = {
    pulseaudio = {
      enable = true;
      support32Bit = true;

      tcp.enable = true;
      tcp.anonymousClients.allowedIpRanges = ["127.0.0.1"];
    };
  };


  # ===========================================================================
  # == USERS ==================================================================
  # ===========================================================================

  users.users.greg = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };


  # ===========================================================================
  # == FONTS ==================================================================
  # ===========================================================================

  fonts.fonts = with pkgs; [
    dina-font
    envypn-font
    fira-code
    fira-code-symbols
    font-awesome_5
    inconsolata
    noto-fonts
    noto-fonts-emoji
    powerline-fonts
    siji
    unifont
  ];


  # ===========================================================================
  # == MISC ===================================================================
  # ===========================================================================

  # Misc.
  users.defaultUserShell = pkgs.zsh;

  # Enable sound.
  sound.enable = true;

  # Localization
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleUseXkbConfig = true;
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";


  # ===========================================================================
  # == SYSTEM =================================================================
  # ===========================================================================

  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  # Portable configuration
  networking.hostName = "Primrose";
  networking.networkmanager.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

  # Clone configurations
  nesting.clone = [
    { boot.loader.grub.configurationName = "Workstation";
      environment.variables.DEVICE = "Workstation";
      imports = [ ./workstation.nix ];
    }

    { boot.loader.grub.configurationName = "Surface";
      environment.variables.DEVICE = "Surface";
      imports = [ ./surface.nix ];
    }
  ];

  environment.shellAliases = {
    "switch-to-default-configuration"     = "/run/current-system/bin/switch-to-configuration";
    "switch-to-workstation-configuration" = "/run/current-system/fine-tune/child-1/bin/switch-to-configuration";
    "switch-to-surface-configuration"     = "/run/current-system/fine-tune/child-2/bin/switch-to-configuration";
  };

  # Disk configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = [
    { name = "root";
      device = "/dev/disk/by-uuid/52901570-1b5a-4c97-903d-16ab8ac47bb9";
      preLVM = true;
      fallbackToPassword = true;
      keyFile = "/dev/disk/by-id/usb-Generic_USB_Flash_Disk-0:0";
      keyFileOffset = 4025000000;
      keyFileSize = 4096;
    }
  ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/d3e07260-0523-45f3-831a-771e3b8a674f";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/DFE2-BFD4";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/dae97eb3-b738-4d2d-acd1-e6dfce017e42"; }
    ];

  # Kernel configuration
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "uas" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Misc configuration
  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
