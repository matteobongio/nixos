{
  config,
  lib,
  pkgs,
  ...
}: {
  xdg.mime.enable = true;
  xdg.menus.enable = true;
  environment.systemPackages = with pkgs; [
    kdePackages.kio
    kdePackages.kio-fuse
    kdePackages.kio-admin
    kdePackages.kio-gdrive
    kdePackages.kio-extras
    kdePackages.dolphin
    kdePackages.kservice
    kdePackages.kdegraphics-thumbnailers
    kdePackages.ark
    kdePackages.okular
    kdePackages.kdf
    kdePackages.qtwayland
    kdePackages.plasma-integration
    kdePackages.qtsvg
    shared-mime-info
  ];
  environment.etc."/xdg/menus/applications.menu".text = builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
}
