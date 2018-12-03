Nix config
==========

I use Nix as both my OS and my package manager (when I don't have
root privileges, or on the Windows Subsystem).

On NixOS, configuration files from this repository can be directly
imported in `/etc/nixos/configuration.nix`. In most cases, it will be used
on a portable SSD, either on my desktop (`workstation.nix`) or on my
Surface Book (`surface.nix`).

For instance:
```nix
# /etc/nixos/configuration.nix
{ config, ... }:

{
  # Assuming the dotfiles have been cloned in /root:
  imports = [ /root/.config/nixos/common.nix
              /root/.config/nixos/portable/default.nix
            ];
}
```
