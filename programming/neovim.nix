{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:
# TODO: delete when https://github.com/NixOS/nixpkgs/issues/402998 is closed
let
  nvim = pkgs-unstable.neovim-unwrapped.overrideAttrs (old: {
    meta =
      old.meta or {}
      // {
        maintainers = [];
      };
  });
in {
  options = {
    neovim.enable = lib.mkEnableOption "enable neovim packages";
  };
  config = lib.mkIf config.neovim.enable {
    programs.nix-ld.enable = true; # allow for clangd dynamic linked libraries
    programs.nix-ld.package = pkgs.nix-ld-rs;
    programs.nix-ld.libraries = with pkgs; [stdenv.cc.cc];
    environment.sessionVariables = {
      EDITOR = "nvim";
    };
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      package = nvim;
    };
    environment.systemPackages = with pkgs; [
      tree-sitter
      neovide
      ripgrep
      wget
      git
      gcc
      unzip
      wl-clipboard #wayland
      xxd
      fzf
      clang-tools
      gnumake
      nodejs #markdown preview

      #lsp
      nil
      lua-language-server
      haskell-language-server
    ];
  };
}
