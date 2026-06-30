{
  config,
  lib,
  pkgs,
  ...
}: let
  portals = [pkgs.xdg-desktop-portal-hyprland pkgs.xdg-desktop-portal-gtk];
in {
  imports = [
    ./hyprland.nix
    ./niri.nix
    ./dolphin.nix
    ./quickshell.nix
  ];
  # programs.waybar.enable = true;
  environment.systemPackages = with pkgs; [
    waybar
    papirus-icon-theme
    notify-desktop
    swaynotificationcenter
    hypridle
    hyprshot
    awww
    eww
    waypaper
    # pamixer //TODO: move to wpctl
    pwvucontrol
    brightnessctl
    networkmanagerapplet
    # polkit_gnome
    hyprpolkitagent
    # kdePackages.plasma-systemmonitor
    # kdePackages.ksystemstats
    gnome-system-monitor
    kdePackages.gwenview
    kdePackages.kimageformats
    # (catppuccin-kvantum.override {
    #   accent = "lavender";
    #   variant = "macchiato";
    # })
    kdePackages.breeze
    kdePackages.breeze-gtk
    themechanger
    nwg-look
    nwg-displays
    qt6Packages.qt6ct
    libsForQt5.qt5ct
    libsForQt5.qt5.qtwayland
    kdePackages.qtwayland
    wofi
  ];

  environment.pathsToLink = [ "/share/color-schemes" ];
  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  security.polkit.enable = true;
  systemd.user.services.hyprpolkitagent = {
    description = "Hyprland PolicyKit Agent";
    wantedBy = ["graphical-session.target"];
    partOf = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.hyprpolkitagent}/bin/hyprpolkitagent";
      Restart = "on-failure";
      RestartSec = 1;
    };
  };

  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true; #enable mtp

  programs.hyprlock.enable = false;

  xdg.portal = {
    enable = true;
    # config.common.default = "*";
    # wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config = {
      common.default = ["gtk"];
      hyprland.default = ["hyprland" "gtk"];
      niri.default = ["gnome" "gtk"];
    };
  };
}
