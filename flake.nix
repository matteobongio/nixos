{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url =  "github:NixOS/nixpkgs/nixos-24.11"; # "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-24-11.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-stable.url = "github:nixos/nixpkgs/5633bcff0c6162b9e4b5f1264264611e950c8ec7";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    dolphin-overlay.url = "github:rumboon/dolphin-overlay";
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, nixos-hardware, nixpkgs-stable, nixpkgs-24-11, dolphin-overlay, ... }@inputs: {
    nixosConfigurations.aster-nixos = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = {
          pkgs-stable = import nixpkgs-stable {
            # Refer to the `system` parameter from
            # the outer scope recursively
            inherit system;
            config.allowUnfree = true;
          };
          pkgs-24-11 = import nixpkgs-24-11 {
            # Refer to the `system` parameter from
            # the outer scope recursively
            inherit system;
            config.allowUnfree = true;
          };
        };
      modules = [
        ./configuration.nix
        ./hosts/aster-nixos/hardware-configuration.nix
        nixos-hardware.nixosModules.system76-gaze18
        nixos-hardware.nixosModules.common-cpu-intel
        {
          nixpkgs.overlays = [ dolphin-overlay.overlays.default ];
        }
        # stylix.nixosModules.stylix
        # home-manager.nixosModules.home-manager {
        #   home-manager.useGlobalPkgs = true;
        #   home-manager.backupFileExtension = "backup";
        #   home-manager.useUserPackages = true;
        #   home-manager.sharedModules = [{
        #     stylix.autoEnable = false;
        #     stylix.targets.kde.enable = true;
        #     stylix.targets.firefox.enable = true;
        #   }];
        #   home-manager.users.matteob = import ./home.nix;
        # }
      ];
    };
  };
}
