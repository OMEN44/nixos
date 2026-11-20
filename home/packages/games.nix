{ pkgs, ... }:
let
  prismlauncherWithJDK =
    with pkgs;
    (prismlauncher.override {
      jdks = [
        jdk8
        jdk17
        jdk21
        jdk25
      ];
    });
in
{
  home.packages = [
    prismlauncherWithJDK
  ];
  # programs.stream = {
  #   enable = true;
  #   remotePlay.openFirewall = true;
  #   dedicatedServer.openFirewall = true;
  # };
}
