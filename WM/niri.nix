{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.niri.enable = true;
  security.pam.services.niri.enableGnomeKeyring = true;
  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];
}
