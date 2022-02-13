{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Desktop environment.
    google-chrome kitty rofi sxhkd xclip xsecurelock
    (polybar.override { pulseSupport = true; })

    # Screenshot utilities.
    (pkgs.writeShellScriptBin "screenshot-full" ''
      outpath="$HOME/Pictures/Screenshots/$(date '+%F_%H.%M.%S.png')"
      ${pkgs.scrot}/bin/scrot -o "$outpath"
      ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png -i "$outpath"
    '')

    (pkgs.writeShellScriptBin "screenshot-selection" ''
      outpath="$HOME/Pictures/Screenshots/$(date '+%F_%H.%M.%S.png')"
      ${pkgs.scrot}/bin/scrot -fos "$outpath" || exit
      ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png -i "$outpath"
    '')
  ];

  environment.variables = {
    BROWSER = "${pkgs.google-chrome}/bin/google-chrome-stable";
    TERMINAL = "${pkgs.kitty}/bin/kitty";
  };

  services = {
    blueman.enable = true;

    picom = {
      enable = true;

      backend = "glx";
      vSync = true;
      fade = true;
      fadeDelta = 3;
      inactiveOpacity = 0.85;
    };

    transmission = {
      enable = true;
    };

    xserver = {
      enable = true;
      libinput.enable = true;

      layout = "us";
      xkbOptions = "compose:ralt";

      dpi = 125;

      autoRepeatDelay = 250;
      autoRepeatInterval = 25;

      videoDrivers = [ "nvidia" ];

      displayManager = {
        defaultSession = "none+bspwm";
        lightdm.greeters.gtk = {
          indicators = [ "~a11y" "~layout" "~spacer" "~clock" "~spacer" "~power"];
          extraConfig = ''
            hide-user-image = true
            background = ${../data/background-image}
            keyboard = ${pkgs.onboard}/bin/onboard
          '';
        };
      };

      windowManager.bspwm = {
        enable = true;
      };
    };
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    dina-font
  ];

  # Enable sound.
  sound.enable = true;
  sound.mediaKeys.enable = true;
  hardware.pulseaudio.enable = true;
}
