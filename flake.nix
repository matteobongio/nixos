{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11"; # "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    dolphin-overlay.url = "github:rumboon/dolphin-overlay";
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # stylix.url = "github:danth/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    nixpkgs-unstable,
    dolphin-overlay,
    ...
  } @ inputs: {
    nixosConfigurations.aster-nixos = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = {
        pkgs-unstable = import nixpkgs-unstable {
          # Refer to the `system` parameter from
          # the outer scope recursively
          inherit system;
          config.allowUnfree = true;
          overlays = [
            dolphin-overlay.overlays.default
          ];
        };
        pkgs = import nixpkgs {
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
