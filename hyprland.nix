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
    hyprpaper
    pamixer
    brightnessctl
  ];
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
