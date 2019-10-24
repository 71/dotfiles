{ config, lib, pkgs, ... }:

{
  # ===========================================================================
  # == PACKAGES ===============================================================
  # ===========================================================================

  environment.systemPackages = with pkgs; [
    alacritty google-chrome onboard xclip
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

      layout = "us";
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
            (pkgs.polybar.override { i3GapsSupport = true; pulseSupport = config.sound.enable; })
            pkgs.rofi
          ];
        };

        default = "i3";
      };

      displayManager.lightdm = {
        background = "${../data/login-wallpaper}";

        greeters.gtk = {
          indicators = ["~a11y" "~layout" "~spacer" "~clock" "~spacer" "~power"];
          extraConfig = ''
            hide-user-image = true
            keyboard = ${pkgs.onboard}/bin/onboard
          '';
        };
      };
    };
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

  # Localization
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleUseXkbConfig = true;
    defaultLocale = "en_US.UTF-8";
  };
}
