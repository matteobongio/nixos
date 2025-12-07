{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    onlyoffice-desktopeditors
    slack
  ];
}
