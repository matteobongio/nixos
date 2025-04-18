{ config, lib, pkgs, pkgs-unstable, ... }:
{
  options = {
    neovim.enable = lib.mkEnableOption "enable neovim packages";
  };
  config = lib.mkIf config.neovim.enable {
    programs.nix-ld.enable = true; # allow for clangd dynamic linked libraries
    programs.nix-ld.package = pkgs.nix-ld-rs;
    programs.nix-ld.libraries = with pkgs; [ stdenv.cc.cc ];
    environment.sessionVariables = {
      EDITOR = "nvim";
    };
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      package = pkgs-unstable.neovim-unwrapped;
    };
    environment.systemPackages = with pkgs; [
      neovide
      ripgrep
      wget
      git
      gcc
      unzip
      wl-clipboard #wayland
      xxd
      fzf
      clang-tools
      nil
      gnumake
      nodejs #markdown preview
    ];
  };
}
