{ config, lib, pkgs, ... }:

let
  nixos = builtins.pathExists /etc/nixos/configuration.nix;

  # The 'system' function imports a NixOS configuration file
  # without including all the NixOS default stuff. Therefore
  # some system packages that are automatically added by
  # NixOS won't be here, and only the configuration itself
  # will be returned, without automatic merges.
  system = x: (import x) {
    inherit config pkgs;

    # mkAfter and all its friends aren't properly resolved since
    # we're not correctly evaluating the module, therefore we
    # have to provide a replacement.
    lib = {
      mkAfter = x: x;
    };
  };

  core = system ../nixos/core.nix;
in
{
  # Packages
  home.packages = with pkgs; [
    (ghc.withPackages (hpkgs: with hpkgs; [ xmonad xmonad-contrib ]))
  ] ++ core.environment.systemPackages;

  # Variables
  home.sessionVariables = {

  } // core.environment.variables;


  # Aliases
  home.file.".aliases".text = lib.concatStrings (
    lib.mapAttrsToList (k: v: "alias ${k}='${v}'\n") core.environment.shellAliases
  );

  # Git
  programs.git = {
    enable = true;
    userName  = "Grégoire Geis";
    userEmail = "git@gregoirege.is";
  };

  # GPG
  services.gpg-agent = {
    enable = true;
  };

  # Enable home-manager
  programs.home-manager = {
    enable = true;
    path   = https://github.com/rycee/home-manager/archive/master.tar.gz;
  };

  # Set state version
  home.stateVersion = core.stateVersion;
}
