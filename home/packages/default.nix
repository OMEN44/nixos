{ pkgs, ... }:

{
  imports = [
    ./bash.nix
    ./btop.nix
    ./git.nix
    ./gnome-extensions.nix
    ./ulauncher.nix
    ./fastfetch.nix
    ./vivaldi.nix
  ];

  home.packages = with pkgs; [
    bat
    nixd
    devenv
    nixfmt
    nixd
    python314
    zellij
    pixi
    ltspice
    nix-output-monitor
    arp-scan
    spotify
    cachix
    fzf
    libreoffice
    obs-studio
    rpi-imager
    kicad
    # camera tools
    guvcview # video device settings editor gui
    v4l-utils

    # lua and qml tools are here since I dont want to use devenv for system config
    lua-language-server
    stylua
    kdePackages.qtdeclarative # for qml language server

    xinit
    kitty
    alacritty
  ];
}
