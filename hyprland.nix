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
  ];
  

  stylix = {
    enable = true;
    image = pkgs.fetchurl {
      url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
      sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  };


  services.gnome.gnome-keyring.enable = true;
  security.pam.services.hyprland.enableGnomeKeyring = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
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
