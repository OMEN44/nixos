{lib, pkgs, ...}: {
  specialisation = {
    hyprland.configuration = {
      # disable gdm and gnome desktop manager
      services.displayManager.gdm.enable = lib.mkForce false;
      services.desktopManager.gnome.enable = lib.mkForce false;

      programs.hyprland = { # we use this instead of putting it in systemPackages/users  
        enable = true;
        xwayland.enable = true;
      };

      environment.sessionVariables.NIXOS_OZONE_WL = "1"; # This variable fixes electron apps in wayland

      environment.systemPackages = with pkgs; [
        foot 
        waybar
        kitty
      ];

      home-manager.users.huon.programs.bash = {
        profileExtra = ''
          hyperland
        '';
      };
    };
  };
}