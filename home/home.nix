{
  ...
}:

{
  home.username = "huon";
  home.homeDirectory = "/home/huon";
  home.stateVersion = "26.05";

  imports = [
    # ./specialisations/gdm
    ./packages
  ];

  # home.file.".config/<app>".source = ./config/<app>;
}
