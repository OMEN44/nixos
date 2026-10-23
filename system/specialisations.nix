{
  lib,
  # quickshell,
  pkgs,
  ...
}:
{
  # default specialisations contains gnome and gdm
  imports = [
    ./display/gnome/gdm.nix
    ./display/hyprland
  ];

  specialisation = {
    tron.configuration = {
      # disable gdm and gnome desktop manager
      # services.displayManager.gdm.enable = lib.mkForce false;
      services.desktopManager.gnome.enable = lib.mkForce false;

      # mangowm
      programs.mango.enable = true;
      services.displayManager = {
        defaultSession = "mango";
      };

      # additional packages
      environment.systemPackages = with pkgs; [
        mango
      ];
    };
  };
}
