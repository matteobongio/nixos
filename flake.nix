{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; # "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-old.url = "github:NixOS/nixpkgs/nixos-24.11"; # "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    dolphin-overlay = {
      url = "github:rumboon/dolphin-overlay";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    go2pkg.url = "github:matteobongio/go2";
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # stylix.url = "github:danth/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-old,
    nixpkgs-unstable,
    nixos-hardware,
    dolphin-overlay,
    go2pkg,
    ...
  } @ inputs: {
    nixosConfigurations = {
      aster-nixos = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              dolphin-overlay.overlays.default
            ];
          };
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          pkgs-old = import nixpkgs-old {
            inherit system;
            config.allowUnfree = true;
          };
        };
        modules = [
          ./configuration.nix
          ./hosts/aster-nixos/hardware-configuration.nix
          ./hosts/aster-nixos/general.nix
          nixos-hardware.nixosModules.system76-gaze18
          nixos-hardware.nixosModules.common-cpu-intel

          {
            environment.systemPackages = [
              go2pkg.packages.${system}.default
            ];
          }
        ];
      };
      #nixos-rebuild boot --flake .#nixos-gaming
      nixos-gaming = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          pkgs-old = import nixpkgs-old {
            inherit system;
            config.allowUnfree = true;
          };
        };
        modules = [
          ./configuration.nix
          ./hosts/gaming/general.nix
        ];
      };
    };
  };
}
