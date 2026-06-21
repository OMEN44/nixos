# Configure git setting the user name and email.
{ config, pkgs, ... }:

{
  git = {
    enable = true;
    settings.user = {
      name = "huon";
      email = "huonswales@gmail.com";
    };
  };
}