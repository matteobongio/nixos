{
  config,
  pkgs,
  pkgs-old,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #nvidia
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.open = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  fileSystems."/mnt/E" = {
    device = "/dev/disk/by-uuid/7a1ab3cb-5263-4c31-83b6-2efefc19e82b";
    fsType = "btrfs";
    options = [
      "defaults"
      "nofail"
      "compress=zstd"
      "autodefrag"
    ];
  };

  fileSystems."/mnt/D" = {
    device = "/dev/disk/by-uuid/e1dad93f-07c6-414c-ab7a-479defa2a672";
    fsType = "btrfs";
    options = [
      "defaults"
      "nofail"
      "compress=zstd"
      "autodefrag"
    ];
  };
  # services.displayManager.sddm.settings = {
  #   Autologin = {
  #     Session = "plasma.desktop";
  #     User = "matteob";
  #   };
  # };
  services.desktopManager.plasma6.enable = true;

  networking.hostName = "nixos-gaming"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_BE.UTF-8";
    LC_IDENTIFICATION = "fr_BE.UTF-8";
    LC_MEASUREMENT = "fr_BE.UTF-8";
    LC_MONETARY = "fr_BE.UTF-8";
    LC_NAME = "fr_BE.UTF-8";
    LC_NUMERIC = "fr_BE.UTF-8";
    LC_PAPER = "fr_BE.UTF-8";
    LC_TELEPHONE = "fr_BE.UTF-8";
    LC_TIME = "fr_BE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "it";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "it2";

  services = {
    jellyfin = {
      enable = true;
    };
    sonarr = {
      enable = true;
      user = "matteob";
      dataDir = "/home/matteob/.config/NzbDrone";
    };
    prowlarr = {
      enable = true;
    };
    flaresolverr.enable = true;
  };

  environment.systemPackages = with pkgs; [
    suwayomi-server
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    jellyfin-media-player
    bitwarden
    (pkgs.makeDesktopItem {
        name = "sonarr-desktop";
        type = "Link";
        desktopName = "sonarr";
        url = "http://localhost:8989";
        icon = "${pkgs.sonarr}/lib/sonarr/UI/Content/Images/logo.svg";
      })
    (pkgs.makeDesktopItem {
        name = "prowlarr-desktop";
        type = "Link";
        desktopName = "prowlarr";
        url = "http://localhost:9696";
        icon = "${pkgs.prowlarr}/share/prowlarr-1.36.3.5071/UI/Content/Images/logo.svg";
      })
    (pkgs.makeDesktopItem {
        name = "suwayomi-desktop";
        type = "Link";
        desktopName = "suwayomi";
        url = "http://localhost:4567";
        icon = "${pkgs.sonarr}/lib/sonarr/UI/Content/Images/logo.svg";
      })
  ];

  systemd.user.services.suwayomi = {
    enable = true;
    after = [ "network.target" ];
    wantedBy = [ "default.target" ];
    description = "suwayomi server";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''"${pkgs.suwayomi-server}/bin/tachidesk-server"'';
    };
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    8080 
    5173 

    9999

    4567 #suwayomi
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.allowedUDPPorts = [22000 21027]; #syncthing
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
