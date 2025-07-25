# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  pkgs-old,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./programming/emacs.nix
    ./programming/neovim.nix
    ./programming/programming.nix
    ./programming/docker.nix
    ./games.nix
    ./office.nix
    ./typst.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  virtualisation.vmware.host.enable = false;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = false;
  # security.pam.services.greetd.enableGnomeKeyring = true;
  # services.greetd = {
  #   enable = true;
  #   settings = rec {
  #     initial_session = {
  #       command = "Hyprland";
  #       user = "matteob";
  #     };
  #     default_session = initial_session;
  #   };
  # };
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  programs.kdeconnect.enable = true;

  environment.sessionVariables = {
    # If your cursor becomes invisible
    #WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    GSK_RENDERER = "gl"; #fixes some gnome apps on wayland ? https://discussion.fedoraproject.org/t/gdk-message-error-71-protocol-error-dispatching-to-wayland-display/127927/6
  };

  # Enable sound with pipewire.
  # services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig.pipewire.qobuz = {
      "context.properties" = {
        "default.clock.allowed-rates" = [44100 48000 88200 96000 192000];
      };
    };
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.matteob = {
    isNormalUser = true;
    description = "Matteo Bongiovanni";
    extraGroups = ["networkmanager" "wheel" "input"];
    packages = with pkgs; [
      kdePackages.kate
      kdePackages.kweather
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.nh = {
    flake = "/home/matteob/nixos";
    enable = true;
  };

  typst.enable = true;
  programming.enable = true;
  docker.enable = true;
  neovim.enable = true;
  emacs.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    thunderbird
    pkgs-unstable.joplin-desktop
    protonmail-bridge-gui
    protonvpn-gui
    (pkgs-old.calibre.override {
      unrarSupport = true; #cbr and cbz
    })
    discord
    kdePackages.kget
    texliveFull
    vulkan-tools #TODO:
    yacreader
    qbittorrent
    mpv
    nushell
    unrar
    bottles
    filezilla
    rustdesk-flutter
    rhash
    gparted
    popsicle
    kdePackages.partitionmanager
    brave
    pcloud
    spotify #TODO:
    pomodoro-gtk
    distrobox
    signal-desktop
    pkgs-old.planify
    libheif
    qdirstat
    krita
    gimp
    obsidian
    #wonderdraft
    soulseekqt
    pkgs-unstable.strawberry-qt6
    handbrake
  ];
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };
  services.flatpak.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    font-awesome
  ];
  services.syncthing = {
    enable = true;
    user = "matteob";
    dataDir = "/home/matteob/Documents"; # Default folder for new synced folders
    configDir = "/home/matteob/.config/syncthing"; # Folder for Syncthing's settings and keys
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
}
