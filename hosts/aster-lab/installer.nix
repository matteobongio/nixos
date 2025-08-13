{
  config,
  pkgs,
  pkgs-old,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./general.nix
  ];

  system.activatable = false;
  networking.hostName = "nixos-install";
  users.users.root.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILVDncDw06I9V51UjwLPMjpdA3LbUcyZGRjGh4dQNCaX"];
}
