{ ... }:

{
  users.users.greg = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
