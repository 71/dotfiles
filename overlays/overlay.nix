self: super:

{
  lesspass = (super.callPackage ./pkgs/lesspass.nix {}).lesspass {};
}

