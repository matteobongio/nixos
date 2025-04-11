{ config, lib, pkgs, pkgs-unstable, ... }:
{
  options = {
    typst.enable = lib.mkEnableOption "enable typst packages";
  };
  config = lib.mkIf config.neovim.enable {
    environment.systemPackages = [
    pkgs-unstable.typst
    pkgs-unstable.tinymist
    ];
  };
}
