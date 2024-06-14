{ config, lib, pkgs, ... }:
{
  options = {
    neovim.enable = lib.mkEnableOption "enable neovim packages";
  };
  config = lib.mkIf config.neovim.enable {
    environment.sessionVariables = {
      EDITOR = "nvim";
    };
    environment.systemPackages = with pkgs; [
      neovim
      ripgrep
      wget
      git
      gcc
      unzip
      wl-clipboard #wayland
      xxd
      fzf
    ];
  };
}
