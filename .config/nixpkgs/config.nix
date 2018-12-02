with (import <nixpkgs> {});
{
  allowUnfree = true;

  packageOverrides = pkgs: with pkgs; {
    haskellEnv = ghc.withPackages (haskellPackages: with haskellPackages; [ xmonad xmonad-contrib ]);
  };
}
