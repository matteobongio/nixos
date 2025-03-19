{ config, lib, pkgs, pkgs-24-11,  ... }:
{
  options = {
    programming.enable = lib.mkEnableOption "enable programming packages";
  };
  config = lib.mkIf config.programming.enable {
    environment.systemPackages = with pkgs; [
    godot_4
    jetbrains.clion
    jetbrains.idea-ultimate
    gh
    rustup
    go
    gdb
    gdbgui
    kitty
    eza
    zoxide
    bat
    lazygit
    yadm
    yazi
    starship
    c3c
    nil
    lua-language-server
    valgrind
    #haskell
    ghc
    haskell-language-server

    pkgs-24-11.gitkraken
    ];
  };
}
