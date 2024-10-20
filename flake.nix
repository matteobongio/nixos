{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, stylix, ... }@inputs: {
    nixosConfigurations.aster-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        ./hosts/aster-nixos/hardware-configuration.nix
        nixos-hardware.nixosModules.system76-gaze18
        nixos-hardware.nixosModules.common-cpu-intel
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.backupFileExtension = "backup";
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [{
            stylix.autoEnable = false;
            stylix.targets.kde.enable = true;
            stylix.targets.firefox.enable = true;
          }];
          home-manager.users.matteob = import ./home.nix;
        }
      ];
    };
  };
}
