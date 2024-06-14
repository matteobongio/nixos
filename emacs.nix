{ config, lib, pkgs, ... }:
{
  options = {
    emacs.enable = lib.mkEnableOption "enable emacs packages";
  };
  config = lib.mkIf config.emacs.enable {
    environment.systemPackages = with pkgs; [
      emacs
      fd
      ripgrep
      git
    ];
  };
}
