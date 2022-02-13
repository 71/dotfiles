{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Core command line tools.
    bat broot curl exa fd fzf procs ripgrep sd wget

    # Extra command line tools.
    du-dust hexyl hyperfine mcfly ripgrep-all xsv zoxide

    # Editing.
    kakoune

    # Source control.
    git delta

    # Configuration.
    networkmanager
  ];

  environment.variables = {
    EDITOR = "${pkgs.kakoune}/bin/kak";
    SHELL = "${pkgs.fish}/bin/fish";

    FZF_DEFAULT_COMMAND = "rg --files";
  };

  environment.shellAliases = {
    # Ensures that aliases after `sudo` are expanded as well.
    sudo = "sudo ";

    # More modern tools.
    cat  = "bat --style plain --paging never";
    ed   = "kak";
    diff = "delta";
    ls   = "exa";
    ps   = "procs";

    # Common commands.
    g = "git";
    k = "kak";

    ssw = "sudo nixos-rebuild switch --flake $HOME/.config/nixos";
    hsw = "home-manager switch --flake $HOME/.config/nixpkgs#$USER";

    bo = "broot --conf ${pkgs.writeText "select.toml" ''
      quit_on_last_cancel = true

      [[verbs]]
      invocation = "ok"
      key = "enter"
      leave_broot = true
      execution = ":print_path"
    ''}";
  };

  programs = {
    fish = {
      enable = true;
      useBabelfish = true;

      promptInit = ''
        function fish_greeting; end
      '';

      interactiveShellInit = ''
        ${pkgs.broot}/bin/broot --print-shell-function fish | source
        ${pkgs.mcfly}/bin/mcfly init fish | source
        ${pkgs.starship}/bin/starship init fish | source
        ${pkgs.zoxide}/bin/zoxide init fish | source

        function edc -d "Edit configuration"
          if test (count $argv) -eq 0
            set target (bo $HOME/.config)
          else
            set target $HOME/.config/$argv[1]
          end
          if test -n "$target"
            $EDITOR $target
          else
            return 1
          end
        end

        function edh -d "Edit home configuration"
          set -a argv home.nix
          $EDITOR $HOME/.config/nixpkgs/$argv[1]
        end

        function eds -d "Edit system configuration"
          set -a argv configuration.nix
          sudo $EDITOR /etc/nixos/$argv[1]
        end

        complete -c edc -f -a '(pushd $HOME/.config; __fish_complete_path (commandline -t); popd)'
        complete -c edh -f -a '(pushd $HOME/.config/nixpkgs; __fish_complete_path (commandline -t); popd)'
        complete -c eds -f -a '(pushd /etc/nixos; __fish_complete_path (commandline -t); popd)'

        function fed -d "Find and edit"
          set -l output (bo $argv)

          if test -n "$output"
            $EDITOR $output
          else
            return 1
          end
        end

        function mustbroot -w broot
          set -l result (broot $argv)
          if test -z $result
            return 1
          else
            echo $result
          end
        end
      '';
    };

    ssh.askPassword = "";
  };

  # Networking.
  networking = {
    firewall.enable = true;
    networkmanager.enable = true;

    nameservers = [ "1.1.1.1" "8.8.8.8" ];
  };

  # Time zone.
  time.timeZone = "Europe/Paris";

  # Internationalization.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Nix.
  system.stateVersion = "21.11";

  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.nixUnstable;

    settings = {
      allowed-users = [ "@wheel" ];
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
