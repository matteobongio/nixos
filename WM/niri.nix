{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.niri.enable = true;
  security.pam.services.niri.enableGnomeKeyring = true;
}
