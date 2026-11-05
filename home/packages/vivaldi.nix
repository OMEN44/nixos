{ pkgs, ... }:
let
  vivaldiBasic = pkgs.vivaldi.override {
    commandLineArgs = "--password-store=basic";
  };
in
{
  home.packages = [
    vivaldiBasic
  ];
}
