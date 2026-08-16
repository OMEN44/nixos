{
  pkgs,
  lib,
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

      # Fix error:
      # since you installed Home Manager via its NixOS module and
      #  'home-manager.useUserPackages' is enabled, you need to add

      environment.pathsToLink = [
        "/share/applications"
        "/share/xdg-desktop-portal"
      ];

      #  to your NixOS configuration so that the portal definitions and DE
      #  provided configurations get linked.

      # setup hyprland with home-manager
      home-manager.users.huon = {
        home = {
          sessionVariables.NIXOS_OZONE_WL = "1";
          packages = with pkgs; [
            dconf
            udis86
          ];
        };
        programs.kitty.enable = true;
        wayland.windowManager.hyprland = {
          enable = true;
          configType = "lua";
          settings = {
            config = {
              general = {
                gaps_in = 5;
                gaps_out = 20;
                border_size = 2;
              };

              decoration = {
                rounding = 10;
              };
            };

            monitor = [
              {
                output = "HDMI-A-1";
                mode = "1920x1080@60";
                position = "0x0";
                scale = 1;
              }
              {
                output = "eDP-1";
                mode = "1920x1080@144.00301";
                position = "1920x0";
                scale = 1;
              }
            ];

            bind = [
              {
                _args = [
                  "SUPER + RETURN"
                  (lib.generators.mkLuaInline "lh.dsp.exec_cmd(\"kitty\")")
                ];
              }
            ];
          };
        };
      };
    };
  };
}
