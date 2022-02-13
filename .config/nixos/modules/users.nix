{ config, pkgs, ... }:

{
  security.sudo.wheelNeedsPassword = true;

  users = {
    mutableUsers = false;

    users = {
      g = {
        isNormalUser = true;
        passwordFile = config.age.secrets.password-g.path;
        extraGroups = [ "audio" "networkmanager" "wheel" ];
        shell = pkgs.fish;
      };

      root.passwordFile = config.age.secrets.password-root.path;
    };
  };
}
