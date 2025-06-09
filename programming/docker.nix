{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    docker.enable = lib.mkEnableOption "enable docker";
  };
  config = lib.mkIf config.docker.enable {
    virtualisation.docker.enable = true;
    environment.systemPackages = with pkgs; [
      docker
    ];
    # virtualisation.docker.rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    # };
  };
}
