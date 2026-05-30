{
  config,
  lib,
  pkgs,
  ...
}: {
  security.pam.services.hyprland.enableGnomeKeyring = true;
  programs.uwsm.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
}
