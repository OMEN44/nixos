# Configure git setting the user name and email.
{ ... }:

{
  programs.git = {
    enable = true;
    settings.user = {
      name = "huon";
      email = "huonswales@gmail.com";
    };
  };
}