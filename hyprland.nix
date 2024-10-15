{ config, lib, pkgs, ... }: 
{
  environment.systemPackages = with pkgs; [
    waybar
    font-awesome
    wofi
    notify-desktop
    swaynotificationcenter
    hyprlock
    hypridle
    hyprpaper
  ];
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
