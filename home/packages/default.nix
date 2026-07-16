{ pkgs, ... }:

{
  imports = [
    ./bash.nix
    ./btop.nix
    ./git.nix
    ./gnome-extensions.nix
    ./ulauncher.nix
  ];

  home.packages = with pkgs; [
    # Add your home packages here, for example:
    bat
    vivaldi
    nixd
    devenv
    nixfmt
    nixd
    python314
    zellij
    pixi
  ];
}
