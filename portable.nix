# Configuration used on my SSD, which is LUKS-encrypted.
#
# It is intended to be portable, but to have a complete
# desktop environment at the same time.

{ config, lib, pkgs, ... }:

let secrets = import ./secrets.nix; in
{
  # ===========================================================================
  # == PACKAGES ===============================================================
  # ===========================================================================

  environment.systemPackages = with pkgs; [
    alacritty firefox ncmpcpp thefuck xclip
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
    };

    mopidy = {
      enable = true;
      extensionPackages = [ pkgs.mopidy-spotify pkgs.mopidy-mopify ];
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
        enabled  = true
        hostname = 127.0.0.1
        port = 6600

        [http]
        enabled  = true
        hostname = 127.0.0.1
        port = 6680
      '';
    };
  };


  # ===========================================================================
  # == PROGRAMS ===============================================================
  # ===========================================================================

  programs = {
    tmux = {
      enable   = false; # Right now I don't use Tmux.
      clock24  = true;
      keyMode  = "vi";
      shortcut = "a";
      terminal = "screen-256color";

      extraTmuxConf = ''
        # General config
        set -g default-command ${pkgs.zsh}/bin/zsh
        set -g default-shell ${pkgs.zsh}/bin/zsh

        set -g mouse on

        # Command delay: short
        set -sg escape-time 1

        # Allow reloading configuration
        bind r source-file /etc/tmux.conf \; display "Tmux config reloaded."

        # Bind | and - to split window horizontally and vertically
        unbind '"'
        unbind %
        bind | split-window -h
        bind - split-window -v

        # Switch pane using Alt+Arrows
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D

        # Swap panes using < >
        bind > swap-pane -D
        bind < swap-pane -U

        # Automatically set window titles
        set -g set-titles on
        set -g set-titles-string '#T'
        set -g automatic-rename

        # Status bar
        set -g status on
        set -g status-interval 1
        set -g status-justify centre
        set -g status-bg 'colour235'
        set -g message-command-fg 'colour222'
        set -g pane-active-border-fg 'colour154'
        set -g message-bg 'colour238'
        set -g message-fg 'colour222'
        set -g message-command-bg 'colour238'
        set -g status-attr none
        set -g pane-border-fg 'colour238'

        set -g status-left \'\'
        set -g status-right \'\'

        setw -g window-status-fg 'colour121'
        setw -g window-status-separator \'\'
        setw -g window-status-attr none
        setw -g window-status-activity-attr none
        setw -g window-status-activity-bg 'colour235'
        setw -g window-status-activity-fg 'colour154'
        setw -g window-status-format '#[fg=colour235,bg=colour235,nobold,nounderscore,noitalics]⮀#[default] #I ⮁ #W #[fg=colour235,bg=colour235,nobold,nounderscore,noitalics]⮀'
        setw -g window-status-current-format '#[fg=colour235,bg=colour238,nobold,nounderscore,noitalics]⮀#[fg=colour222,bg=colour238] #I ⮁ #W #[fg=colour238,bg=colour235,nobold,nounderscore,noitalics]⮀'
      '';
    };
  };

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
  # == SYSTEM =================================================================
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
  # == HARDWARE ===============================================================
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
      environment.variables."DEVICE" = "Workstation";
      imports = [ ./workstation.nix ];
    }

    { boot.loader.grub.configurationName = "Surface";
      environment.variables."DEVICE" = "Surface";
      imports = [ ./surfacebook.nix ];
    }
  ];

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
