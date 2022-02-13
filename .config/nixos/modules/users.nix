{ config, pkgs, ... }:

{
  imports = [
    ./user-passwords.nix
  ];

  security.sudo.wheelNeedsPassword = true;

  users = {
    mutableUsers = false;

    users = {
      g = {
        isNormalUser = true;
        extraGroups = [ "audio" "networkmanager" "wheel" ];
        shell = pkgs.fish;
      };
    };
  };
}
