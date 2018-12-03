{ file ? /etc/nixos/configuration.nix }:

import <nixpkgs/nixos/lib/eval-config.nix> {
  modules = [
    (import file)
  ];
}
