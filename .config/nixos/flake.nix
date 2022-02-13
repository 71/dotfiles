{
  inputs = {
    agenix.url = "github:ryantm/agenix";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = { self, nixpkgs, agenix, impermanence, ... }:
    let
      configurations = {
        Penrose = {
          hostId = "57b3bb34";

          modules = [
            ./systems/penrose.nix
          ];
        };
      };
    in
    {
      nixosConfigurations = builtins.mapAttrs
        (hostName: { hostId, modules, system ? "x86_64-linux" }:
          let
            coreModule = { ... }: {
              networking = {
                inherit hostId hostName;
              };

              environment.systemPackages = [
                agenix.defaultPackage.${system}
              ];
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit system;

            modules = modules ++ [
              coreModule

              agenix.nixosModules.age
              impermanence.nixosModules.impermanence
            ];
          })
        configurations;
    };
}
