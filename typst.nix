{ config, lib, pkgs, ... }:
{
  options = {
    typst.enable = lib.mkEnableOption "enable typst packages";
  };
  config = lib.mkIf config.neovim.enable {
    environment.systemPackages = with pkgs; [
    typst
    typst-lsp
    tinymist
    # typst-preview #remove?
    ];
  };
}
