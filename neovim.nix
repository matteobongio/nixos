{ config, lib, pkgs, ... }:
{
  options = {
    neovim.enable = lib.mkEnableOption "enable neovim packages";
  };
  config = lib.mkIf config.neovim.enable {
    environment.sessionVariables = {
      EDITOR = "nvim";
    };
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
    };
    environment.systemPackages = with pkgs; [
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
