{ ... }:

{
  environment.persistence."/nix/state" = {
    directories = [
      "/etc/nixos"
      "/etc/NetworkManager"
      "/srv"
      "/var/lib"
      "/var/log"
    ];
    files = [
      "/etc/machine-id"
      "/etc/nix/id_rsa"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
    ];
  };
}
