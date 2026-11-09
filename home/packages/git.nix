# Configure git setting the user name and email.
{ ... }:

{
  programs.git = {
    enable = true;
    settings.user = {
      name = "OMEN44";
      email = "huonswales@gmail.com";
    };
  };
}
