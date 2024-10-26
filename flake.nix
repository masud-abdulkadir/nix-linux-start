{
  description = "Nix configuration for Arch Linux with Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nur, nix-index-database, ... }:
    let
      username = "dlurker";
      homeDir = "/home/${username}";
      system = "x86_64-linux";  # Adjust if on a different architecture
      pkgs = import nixpkgs { inherit system; overlays = [ nur.overlay ]; };
    in {
      homeConfigurations = {
        "${username}" = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          homeDirectory = homeDir;
          username = username;

          configuration = import ./home.nix {
            inherit pkgs nix-index-database username homeDir;
          };
        };
      };

      # Add formatter, using Alejandra
      formatter.x86_64-linux = pkgs.alejandra;
    };
}

