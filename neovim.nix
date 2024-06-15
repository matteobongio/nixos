{ config, lib, pkgs, ... }:
{
  options = {
    neovim.enable = lib.mkEnableOption "enable neovim packages";
  };
  config = lib.mkIf config.neovim.enable {
    # programs.nix-ld.enable = true; # allow for clangd dynamic linked libraries
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
      clang-tools
    ];
  };
}
