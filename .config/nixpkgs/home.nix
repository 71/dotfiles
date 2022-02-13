{ config, lib, pkgs, ... }:

{
  nixpkgs.config = import ./config.nix;

  home.packages = [
    pkgs.lesspass
  ];

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    direnv = {
      enable = true;
    };

    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        arrterian.nix-env-selector
        matklad.rust-analyzer
        vadimcn.vscode-lldb
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        { name = "dance";
          publisher = "gregoire";
          version = "0.5.8";
          sha256 = "185x4qlcfhky1wjn2yq8b0kabqmxp4jb7rb6rmvj4lfa81p9265a";
        }
        { name = "code-settings-sync";
          publisher = "Shan";
          version = "3.4.3";
          sha256 = "0wdlf34bsyihjz469sam76wid8ylf0zx2m1axnwqayngi3y8nrda";
        }
      ];
    };
  };

  # Desktop entries, needed to automatically open the right programs with
  # `xdg-open`.
  xdg.desktopEntries = {
    broot = {
      name = "Broot";
      genericName = "Directory Traversal";
      exec = "broot %U";
      terminal = true;
      mimeType = [ "inode/directory" ];
    };

    kakoune = {
      name = "Kakoune";
      genericName = "Text Editor";
      exec = "kak %U";
      terminal = true;
      mimeType = [ "text/plain" "text/rust" ];
    };
  };
}
