{ config, lib, pkgs, ... }: 
{
  environment.systemPackages = with pkgs; [
    waybar
  ];
  programs.hyprland = {
    enable = false;
    xwayland.enable = true;
  };
}
