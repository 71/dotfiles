{ config, lib, pkgs, ... }:

let
  # Properties
  nixos = builtins.pathExists /etc/nixos/configuration.nix;

  # Utilities
  system = xs: (import <nixpkgs/nixos/lib/eval-config.nix> {
    modules = map (x: import x) xs;
  }).config;

  drop = origin: toRemove: builtins.filter (x: ! builtins.elem x toRemove) origin;
  trim = f: sys:
    let
      def = f default;
      totrim = f sys;

      triminside = a: b:
        if builtins.isList a then
          (map triminside (builtins.filter (x: ! builtins.elem x b)))
        else if builtins.isAttrs a then
          (lib.mapAttrs (n: x: triminside x (b.${n})) (removeAttrs a (builtins.attrNames b)))
        else
          a;
    in
      triminside totrim def;

  # System configurations
  default = system [];
  core    = system [ ../nixos/core.nix ];
in
{
  # Packages
  home.packages = with pkgs; [
    (ghc.withPackages (hpkgs: with hpkgs; [ xmonad xmonad-contrib ]))
  ] ++ drop core.environment.systemPackages default.environment.systemPackages;

  # Variables
  home.sessionVariables =
    removeAttrs
      ((trim (x: x.environment.variables) core) // (trim (x: x.environment.sessionVariables) core))
      [ "NIX_PATH" ];


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
