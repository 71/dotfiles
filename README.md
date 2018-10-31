Nix config
==========

In most cases, I'll use Nix on a portable SSD, either on my desktop
(`workstation.nix`) or on my Surface Book (`surface.nix`).

This repo should be cloned in `/etc/nixos/config`. Then, different
files can be imported in `/etc/nixos/configuration.nix`.

For instance:
```nix
{ config, ... }:

{
  imports = [ ./config/common.nix ./config/portable/default.nix ];
}
```

## Portable
The `portable` configuration lives on an SSD, and may need to change
depending on the computer on which it runs.

Therefore, it uses `nesting.clone` to allow a different configuration
to be loaded on boot.

