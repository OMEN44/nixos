{
  lib,
  quickshell,
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
      services.displayManager.gdm.enable = lib.mkForce false;
      services.desktopManager.gnome.enable = lib.mkForce false;

      # cinnamon desktop manager
      services.xserver = {
        enable = true;
        desktopManager = {
          xfce.enable = true;
          xterm.enable = true;
        };
        # displayManager = {
        #   lightdm.enable = true;
        # };
      };

      # additional home-manager packages for this specialisation
      # home-manager.users.huon.packages = [
      #   quickshell.packages.${pkgs.system}.default
      # ];
    };
  };
}
