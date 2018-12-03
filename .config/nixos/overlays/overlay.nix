self: super:

let
  pkgs = builtins.filter
          (x: null != builtins.match ".+\\.nix" x)
          (builtins.attrNames (builtins.readDir ../../nixpkgs/overlays));
in
builtins.listToAttrs
  (map
    (x: { name  = builtins.elemAt (builtins.match "(.+)\\.nix" x 0);
          value = super.callPackage (builtins.toPath x) {}; })
    (pkgs))
