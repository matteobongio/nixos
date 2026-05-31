{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:matteobongio/nixos-hardware/system76/gaze18"; # "github:NixOS/nixos-hardware/master";
    go2pkg.url = "github:matteobongio/go2";
    nf.url = "gitlab:MatteoBongio/nf";
    nf.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixos-hardware,
    go2pkg,
    nf,
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
        };
      }
    );
  in {
    packages.${system}.aster-lab-iso = self.nixosConfigurations.aster-lab-iso.config.system.build.isoImage;
    nixosConfigurations = {
      aster-nixos = mkSystem [
        ./configuration.nix
        ./hosts/aster-nixos/hardware-configuration.nix
        ./hosts/aster-nixos/general.nix
        nixos-hardware.nixosModules.system76-gaze18

        {
          environment.systemPackages = [
            go2pkg.packages.${system}.default
            nf.packages.${system}.default
          ];
        }
      ];
      #nixos-rebuild boot --flake .#nixos-gaming
      nixos-gaming = mkSystem [
        ./configuration.nix
        ./hosts/gaming/general.nix
        {
          environment.systemPackages = [
            go2pkg.packages.${system}.default
            nf.packages.${system}.default
          ];
        }
      ];
      aster-lab = mkSystem [
        ./hosts/aster-lab/general.nix
      ];
      aster-lab-iso = mkSystem [
        ({ pkgs, modulesPath, ... }: {
            imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
          })
        ./hosts/aster-lab/installer.nix
      ];
    };
  };
}
