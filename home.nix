{
  config,
  pkgs,
  ...
}:

{
  home.username = "huon";
  home.homeDirectory = "/home/huon";
  home.stateVersion = "26.05";

  programs = (import ./home-programs.nix) { config = config; pkgs = pkgs; };

  # home.file.".config/<app>".source = ./config/<app>;

  home.packages = with pkgs; [
    # Add your home packages here, for example:
    bat
    vivaldi
    nixd
    rofi
  ];
}