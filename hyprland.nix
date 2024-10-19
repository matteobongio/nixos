{ config, lib, pkgs, ... }: 
{
  environment.systemPackages = with pkgs; [
    waybar
    font-awesome
    wofi
    papirus-icon-theme
    notify-desktop
    swaynotificationcenter
    hyprlock
    hypridle
    hyprshot
    hyprcursor
    #hyprpaper
    swww
    waypaper
    pamixer
    brightnessctl
    xdg-desktop-portal-hyprland
    kdePackages.xdg-desktop-portal-kde
    dolphin
    kdePackages.kio-fuse
    kdePackages.kio-extras
    catppuccin-kde
  ];
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.hyprland.enableGnomeKeyring = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables = {
    QT_STYLE_OVERRIDE = "catppuccin-kde";
  };
  xdg.portal = {
    enable = true;
    config = {
      hyprland = {
        default = [
          "hyprland"
          "kde"
        ];
      };
    };
    configPackages = with pkgs; [
      xdg-desktop-portal-hyprland
      kdePackages.xdg-desktop-portal-kde
    ];
  };
}
