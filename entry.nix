{ config, lib, pkgs, ... }:

{
  # Import device-specific config first.
  imports = [ "/etc/nixos/config/${lib.fileContents /etc/nixos/device}.nix" ];


  # ===========================================================================
  # == PACKAGES ===============================================================
  # ===========================================================================

  environment.systemPackages = with pkgs; [
    # Python & co.
    (python3.withPackages (pyPkgs: [ pyPkgs.neovim ]))

    # Compilers
    gcc

    # Misc.
    alacritty lf git neovim thefuck tmux xclip wget zsh
  ];


  # ===========================================================================
  # == ENVIRONMENT ============================================================
  # ===========================================================================

  environment.shellAliases = {
    g    = "git";
    gs   = "git status";
    nv   = "nvim";
    nvc  = "nvim /etc/nixos/config/entry.nix";
    rgit = "git --git-dir=/etc/nixos/config/.git --work-tree=/etc/nixos/config";
    ugit = "git --git-dir=$HOME/.cfg --work-tree=$HOME";

    nxsw = "nixos-rebuild switch";
  };

  environment.variables = {
    EDITOR   = "nvim";
    SHELL    = "zsh";
    TERMINAL = "alacritty";
  };


  # ===========================================================================
  # == SERVICES ===============================================================
  # ===========================================================================

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


  # ===========================================================================
  # == PROGRAMS ===============================================================
  # ===========================================================================

  programs = {
    tmux = {
      enable   = false;
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

    zsh.enable = true;
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

  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleUseXkbConfig = true;
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Only change this if the release notes tell us to do so.
  system.stateVersion = "18.03";
}

