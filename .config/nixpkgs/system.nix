file:

import <nixpkgs/nixos/lib/eval-config.nix> {
  modules = [ import file ];
}
