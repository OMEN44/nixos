{
  pkgs,
  ...
}:

{
  home.username = "huon";
  home.homeDirectory = "/home/huon";
  home.stateVersion = "26.05";

  imports = [
    ./dconf.nix

    # packages
    ./packages/ulauncher.nix
    # ./packages/rofi.nix
    ./packages/git.nix
    ./packages/gnome-extensions.nix
    ./packages/bash.nix
  ];

  # home.file.".config/<app>".source = ./config/<app>;

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
  ];
}