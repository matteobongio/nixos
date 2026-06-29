{
  config,
  lib,
  pkgs,
  ...
}: 
{
  systemd.user.services.hypridle = {
    description = "hypridle idle daemon";
    partOf = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.hypridle}/bin/hypridle";
      Restart = "on-failure";
    };
  };
}
