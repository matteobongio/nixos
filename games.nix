{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    protontricks.enable = true;
  };

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
    protonup-ng
    prismlauncher
    #lutris
    heroic
    melonDS
    gzdoom
    wine
    winetricks
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "~/.steam/root/compatibilitytools.d";
  };
}
