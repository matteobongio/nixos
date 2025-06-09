{
  config,
  lib,
  pkgs,
  ...
}: let
  portals = [pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk];
in {
  environment.systemPackages = with pkgs; [
    waybar
    wofi
    papirus-icon-theme
    notify-desktop
    swaynotificationcenter
    hypridle
    hyprshot
    swww
    eww
    waypaper
    pamixer
    pwvucontrol
    brightnessctl
    networkmanagerapplet
    polkit_gnome
    kdePackages.kio-extras
    (catppuccin-kvantum.override {
      accent = "lavender";
      variant = "macchiato";
    })
    themechanger
    nwg-look
    qt6ct
    libsForQt5.qt5ct
    libsForQt5.qt5.qtwayland
    kdePackages.qtwayland
    kdePackages.qtstyleplugin-kvantum
  ];
  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "kvantum";
  };
  security.polkit.enable = true;
  # environment.pathsToLink = [ "${pkgs.kdePackages.polkit-kde-agent-1}/libexec" ];
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      enable = true;
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.udisks2.enable = true;
  security.pam.services.hyprland.enableGnomeKeyring = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.hyprlock.enable = true;
  xdg.portal = {
    enable = true;
    config.common.default = "*";
    # wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = portals;
  };
}
