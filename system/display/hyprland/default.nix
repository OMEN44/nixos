{ lib, pkgs, ... }: {
  specialisation = {
    hyprland.configuration = {
      # disable gdm and gnome desktop manager
      services.displayManager.gdm.enable = lib.mkForce false;
      services.desktopManager.gnome.enable = lib.mkForce false;

      # since you installed Home Manager via its NixOS module and 'home-manager.useUserPackages' is enabled, you need to add
      environment.pathsToLink = [
        "/share/applications"
        "/share/xdg-desktop-portal"
      ];

      home-manager.users.huon = {
        wayland.windowManager.hyprland.enable = true;
        home = {
          packages = with pkgs; [
            alacritty
          ];
        };
      };
    };
  };
}
