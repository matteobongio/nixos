{
  config,
  lib,
  pkgs,
  ...
}: {
  security.pam.services.hyprland.enableGnomeKeyring = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
