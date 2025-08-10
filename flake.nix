{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; # "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-old.url = "github:NixOS/nixpkgs/nixos-24.11"; # "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-hardware.url = "path:/home/matteob/nixos-hardware";
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
  } @ inputs: 
  let
    system = "x86_64-linux";
    pkgsUnstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
    pkgsStable = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    pkgsOld = import nixpkgs-old {
      inherit system;
      config.allowUnfree = true;
    };
  in
  {
    nixosConfigurations = {
      aster-nixos = nixpkgs.lib.nixosSystem rec {
        inherit system;
        pkgs = pkgsStable;
        specialArgs = {
          pkgs-unstable = pkgsUnstable;
          pkgs-old = pkgsOld;
        };
        modules = [
          ./configuration.nix
          ./hosts/aster-nixos/hardware-configuration.nix
          ./hosts/aster-nixos/general.nix
          nixos-hardware.nixosModules.system76-gaze18
          # nixos-hardware.nixosModules.common-cpu-intel

          {
            environment.systemPackages = [
              go2pkg.packages.${system}.default
            ];
          }
        ];
      };
      #nixos-rebuild boot --flake .#nixos-gaming
      nixos-gaming = nixpkgs.lib.nixosSystem rec {
        inherit system;
        pkgs = pkgsStable;
        specialArgs = {
          pkgs-unstable = pkgsUnstable;
          pkgs-old = pkgsOld;
        };
        modules = [
          ./configuration.nix
          ./hosts/gaming/general.nix
        ];
      };
    };
  };
}
