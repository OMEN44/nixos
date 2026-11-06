{
  description = "Flake for my personal laptop";

  inputs = {
    nixpkgs = {
      url = "nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      mangowm,
      ...
    }:
    {
      nixosConfigurations = {
        "OMEN-Laptop" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            {
              nixpkgs.overlays = [
                (
                  final: _prev:
                  let
                    src = final.fetchFromGitHub {
                      owner = "gfhdhytghd";
                      repo = "HyprCapture";
                      rev = "1192840fcd7d6d48f48a1a090b482c5dc54ccf28";
                      hash = "sha256-W/WYtK5E3q0pluZ+VMVLsxywN0fqAwHw2PP8rSvLVfc=";
                    };
                  in
                  {
                    hyprcapture = final.callPackage "${src}/nix/package.nix" { inherit src; };
                  }
                )
              ];
            }
            # home-manager configuration
            mangowm.nixosModules.mango
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                backupFileExtension = "bak";
                users.huon = import ./home/home.nix;
              };
            }
          ];
        };
      };
    };
}
