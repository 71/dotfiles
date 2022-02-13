{
  description = "home-manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    lesspass.url = "/home/g/source/71/lesspass.rs";
    lesspass.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, lesspass, ... }:
    let
      username = "g";
      system = "x86_64-linux";
    in
    {
      homeConfigurations = {
        ${username} = home-manager.lib.homeManagerConfiguration {
          inherit system username;
  
          homeDirectory = "/home/${username}";
  
          stateVersion = "21.11";
          configuration.imports = [ ./home.nix ];
  
          pkgs = import nixpkgs {
            inherit system;
  
            overlays = [ (self: super: { lesspass = lesspass.defaultPackage.${self.system}; }) ];
          };
        };
      };
    };
}

