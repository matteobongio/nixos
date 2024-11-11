{ config, lib, pkgs, ... }: 
{
  environment.systemPackages = with pkgs; [
    waybar
    wofi
    papirus-icon-theme
    notify-desktop
    swaynotificationcenter
    hyprlock
    hypridle
    hyprshot
    swww
    waypaper
    pamixer
    brightnessctl
    networkmanagerapplet
    polkit_gnome
  ];
  security.polkit.enable = true;
# environment.pathsToLink = [ "${pkgs.kdePackages.polkit-kde-agent-1}/libexec" ];
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  services.gnome.gnome-keyring.enable = true;
  services.udisks2.enable = true;
  security.pam.services.hyprland.enableGnomeKeyring = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
   xdg.portal = {
    enable = true;
    config.common.default = "*";
    # wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals =
      [ pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk ];
  };
}
