{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    virt.enable = lib.mkEnableOption "enable VM packages";
  };
  config = lib.mkIf config.virt.enable {
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["matteob"];
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    # virtualisation.vmware.host.enable = false;
    # virtualisation.waydroid.enable = false;
  };
}
