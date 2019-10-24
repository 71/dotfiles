{ ... }:

{
  imports =
    [
      ../modules/audio.nix
      ../modules/desktop-environment.nix
      ../modules/me.nix
    ];

  networking.hostName = "Penrose";
  networking.wireless.enable = true;
}
