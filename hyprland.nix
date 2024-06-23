{ config, lib, pkgs, ... }: 
{
  environment.systemPackages = with pkgs; [
    waybar
  ];
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
