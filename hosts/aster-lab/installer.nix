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
  ];
  programming.enable = true;

  neovim.enable = true;

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
  system.activatable = false;
  networking.hostName = "nixos-install";
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
  users.users.root.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILVDncDw06I9V51UjwLPMjpdA3LbUcyZGRjGh4dQNCaX"];
}
