{ pkgs, ... }:

{
  # Enable the GNOME desktop environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.games.enable = false;

  # remove bloat
  environment.gnome.excludePackages = with pkgs; [
    gnome-calculator
    gnome-contacts
    gnome-maps
    gnome-software
    epiphany
    yelp
    gnome-weather
    gnome-tour
  ];
}
