{ config, lib, pkgs, ... }:
{
  options = {
    programming.enable = lib.mkEnableOption "enable programming packages";
  };
  config = lib.mkIf config.programming.enable {
    environment.systemPackages = with pkgs; [
    git
    delta
    godot_4
    jetbrains.clion
    jetbrains.idea-ultimate
    gh
    rustup
    go
    gdb
    gdbgui
    kitty
    fastfetch
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
    alejandra
    gitkraken
    ];
  };
}
