{
  config,
  pkgs,
  pkgs-old,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./../../programming/neovim.nix
    ./../../programming/programming.nix
    ./../../programming/docker.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  users.users.matteob = {
    isNormalUser = true;
    description = "Matteo Bongiovanni";
    extraGroups = ["networkmanager" "wheel" "input"];
  };

  programs.fish.enable = true;

  programs.nh = {
    flake = "/home/matteob/nixos";
    enable = true;
  };

  programming.enable = true;

  docker.enable = true;

  neovim.enable = true;

  environment.systemPackages = with pkgs; [
    nushell
    unrar
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    jellyfin-media-player
  ];

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    font-awesome
  ];

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

  networking = {
    usePredictableInterfaceNames = false;
    interfaces.eth0.ipv4.addresses = [
      {
        address = "192.168.1.88";
        prefixLength = 24;
      }
    ];
    defaultGateway = "192.168.1.1";
    nameservers = ["1.1.1.1"];
  };

  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };
}
