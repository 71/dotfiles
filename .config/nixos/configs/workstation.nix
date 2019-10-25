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

  # Enable hardware 2FA
  hardware.u2f.enable = true;

  # Enable Chromecast
  networking.firewall.extraCommands = ''
    iptables -A nixos-fw -p udp -m udp -s 192.168.0.0/16 --match multiport --dports 1900,5353 -j nixos-fw-accept
  '';
}
