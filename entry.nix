{ config, lib, pkgs, ... }:

{
  imports = [ "/etc/nixos/config/${lib.fileContents /etc/nixos/device}.nix" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleUseXkbConfig = true;
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    git lf neovim termite xclip wget zsh
  ];

  environment.variables.TERMINAL = "termite";

  environment.interactiveShellInit = ''
    alias g='git'
    alias gs='git status'
    alias nv='nvim'
    alias nvc='nvim /etc/nixos/config/entry.nix'
    alias rootg="git --git-dir=/etc/nixos/config/.git --work-tree=/etc/nixos/config"
    alias userg="git --git-dir=$HOME/.cfg --work-tree=$HOME"
  '';

  programs.bash.enableCompletion = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      libinput.enable = true;

      windowManager = {
        i3 = {
          enable = true;
          package = pkgs.i3-gaps;
	  extraPackages = [ (pkgs.polybar.override { i3GapsSupport = true; }) pkgs.rofi ];
        };
        default = "i3";
      };
    };
  };

  networking.networkmanager.enable = true;

  fonts.fonts = with pkgs; [
    dina-font
    envypn-font
    inconsolata
    noto-fonts
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    font-awesome_5
    siji
    unifont
  ];

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
