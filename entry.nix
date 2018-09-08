{ config, pkgs, ... }:

{
  imports =
    let r = builtins.tryEval (
      let
        device-name = builtins.readFile /sys/class/dmi/id/product_name;
        devices =
          {
	    "Surface Book" = ./surfacebook.nix;
          };
      in builtins.getAttr device-name devices
    );

    in [ (if r.success then r.value else ./workstation.nix) ]
  ;

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
  '';

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

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
