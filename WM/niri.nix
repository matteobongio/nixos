{
  config,
  lib,
  pkgs,
  ...
}: 
let
in
{
  programs.niri.enable = true;
  security.pam.services.hyprland.enableGnomeKeyring = true;
}
