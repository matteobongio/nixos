{
  config,
  lib,
  pkgs,
  pkgs-old,
  pkgs-unstable,
  ...
}: {
  options = {
      print.enable = lib.mkEnableOption "enable printing support";
  };
  config = lib.mkIf config.print.enable {
    # Enable CUPS to print documents.
    services.printing = {
      enable = true;
      drivers = with pkgs; [ 
        hplip
        hplipWithPlugin
      ];
    };
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    # environment.systemPackages = with pkgs; [
    #   kdePackages.print-manager
    # ];
  };
}
