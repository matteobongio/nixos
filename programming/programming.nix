{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    programming.enable = lib.mkEnableOption "enable programming packages";
  };
  config = lib.mkIf config.programming.enable {
    environment.systemPackages = with pkgs; [
      kitty
      fastfetch
      eza
      fd
      zoxide
      bat
      yadm
      yazi
      starship
      git
      delta
      gh
      gdb
      gdbgui
      lazygit
      valgrind
      jq
      just

      godot_4
      jetbrains.clion
      jetbrains.idea-ultimate

      alejandra

      ghc #haskell
      rustup
      go
      c3c
    ];
  };
}
