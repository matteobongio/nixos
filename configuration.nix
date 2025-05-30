# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-old, pkgs-unstable, ... }:
{
  imports =
    [ 
      ./programming/emacs.nix
      ./programming/neovim.nix
      ./programming/programming.nix
      ./programming/docker.nix
      ./games.nix
      ./office.nix
      ./typst.nix
      ./hyprland.nix
    ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  virtualisation.waydroid.enable = false;
  hardware.graphics.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes"];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "aster-nixos"; # Define your hostname.
  virtualisation.vmware.host.enable = false;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = false;
  security.pam.services.greetd.enableGnomeKeyring = true;
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "Hyprland";
        user = "matteob";
      };
      default_session = initial_session;
    };
  };
  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;
  # Enable the KDE Plasma Desktop Environment.
  # specialisation = {
  #   plasma.configuration = {
  #     #services.desktopManager.plasma6.enable = true;
  #   };
  #   hyprland.configuration = {
  #     imports = [
  #       ./hyprland.nix
  #     ];
  #   };
  # };
  # services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;

  environment.sessionVariables = {
    # If your cursor becomes invisible
    #WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    NH_FLAKE = "/home/matteob/nixos";
    GSK_RENDERER="gl"; #fixes some gnome apps on wayland ? https://discussion.fedoraproject.org/t/gdk-message-error-71-protocol-error-dispatching-to-wayland-display/127927/6
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  # services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
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
    extraGroups = [ "networkmanager" "wheel" "input"];
    packages = with pkgs; [
      kdePackages.kate
      kdePackages.kweather
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  programs.fish.enable = true;

  #bluetooth
  hardware.bluetooth.enable = false;
  services.blueman.enable = false;

  typst.enable = true;
  programming.enable = true;
  docker.enable = true;
  neovim.enable = true;
  emacs.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    thunderbird
    joplin-desktop
    protonmail-bridge-gui
    protonvpn-gui
    nh
    (pkgs-old.calibre.override {
     unrarSupport = true; #cbr and cbz
    })
    discord
    kdePackages.kget
    texliveFull
    vulkan-tools
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
    spotify
    pomodoro-gtk
    distrobox
    pkgs-unstable.kdePackages.dolphin
    kdePackages.kservice
    kdePackages.kdegraphics-thumbnailers
    kdePackages.ark
    kdePackages.okular
    kdePackages.plasma-systemmonitor
    signal-desktop
    pkgs-old.planify
    kdePackages.gwenview
    kdePackages.kimageformats
    libheif
    qdirstat
    krita
    gimp
    obsidian
    wonderdraft
    soulseekqt
    strawberry-qt6
  ];
  programs.direnv.enable = true;
  services.flatpak.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    # fira-code-nerdfont
    font-awesome
  ];
  services.syncthing = {
    enable = true;
    user = "matteob";
    dataDir = "/home/matteob/Documents";    # Default folder for new synced folders
    configDir = "/home/matteob/.config/syncthing";   # Folder for Syncthing's settings and keys
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

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8080 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ]; #syncthing
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
