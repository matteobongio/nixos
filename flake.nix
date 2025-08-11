{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; 
    nixpkgs-old.url = "github:NixOS/nixpkgs/nixos-24.11"; 
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "path:/home/matteob/nixos-hardware"; # "github:NixOS/nixos-hardware/master";
    go2pkg.url = "github:matteobongio/go2";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-old,
    nixpkgs-unstable,
    nixos-hardware,
    go2pkg,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    mkPkgs = pkgs: (
      import pkgs {
        inherit system;
        config.allowUnfree = true;
      }
    );
    mkSystem = modules: (
      nixpkgs.lib.nixosSystem rec {
        inherit system modules;
        pkgs = mkPkgs nixpkgs;
        specialArgs = {
          pkgs-unstable = mkPkgs nixpkgs-unstable;
          pkgs-old = mkPkgs nixpkgs-old;
        };
      }
    );
  in {
    nixosConfigurations = {
      aster-nixos = mkSystem [
        ./configuration.nix
        ./hosts/aster-nixos/hardware-configuration.nix
        ./hosts/aster-nixos/general.nix
        nixos-hardware.nixosModules.system76-gaze18

        {
          environment.systemPackages = [
            go2pkg.packages.${system}.default
          ];
        }
      ];
      #nixos-rebuild boot --flake .#nixos-gaming
      nixos-gaming = mkSystem [
        ./configuration.nix
        ./hosts/gaming/general.nix
      ];
    };
  };
}
