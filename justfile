build-lab-iso:
   nix build .#nixosConfigurations.aster-lab-iso.config.system.build.isoImage

