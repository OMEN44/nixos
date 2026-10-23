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
    # quickshell = {
    #   url = "github:quickshell-mirror/quickshell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      mangowm,
      # quickshell,
      ...
    }:
    {
      nixosConfigurations = {
        "OMEN-Laptop" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
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
