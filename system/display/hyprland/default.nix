{ lib, pkgs, ... }:
{
  specialisation.hyprland.configuration = {
    # disable gnome desktop manager
    services.desktopManager.gnome.enable = lib.mkForce false;

    programs = {
      hyprland = {
        enable = true;
        withUWSM = true;
      };
      dconf.enable = true;
    };
    services.displayManager.defaultSession = "hyprland-uwsm";
    services.blueman.enable = true;
    services.upower.enable = true;
    services.udisks2.enable = true;

    # since you installed Home Manager via its NixOS module and 'home-manager.useUserPackages' is enabled, you need to add
    environment.pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
      "/share/hypr"
    ];

    home-manager.users.huon = { config, pkgs, ... }: {
      home.packages = with pkgs; [
        wofi
        nautilus
        quickshell
        libnotify
        xdg-utils
        # clipboard manager
        wl-clipboard
        wl-clip-persist
        cursor-clip
        # notifications
        mako
        # screenshot tool
        hyprcapture
        ffmpeg
        # colour picker
        hyprpicker
        # auth agent (lets apps make admin prompts)
        hyprpolkitagent
        # wallpaper
        hyprpaper
        # open apps with sudo
        lxqt.lxqt-policykit
        # auto mount drives
        udiskie
      ];

      home.sessionVariables.HYPRCAPTURE_PLUGIN = "${pkgs.hyprcapture}/lib/libhyprcapture.so";

      xdg.configFile."quickshell".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dots/quickshell";
      xdg.configFile."hypr".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dots/hyprland/hypr";

      services.mako = {
        enable = true;
        settings = {
          # "actionable=true" = {
          #   anchor = "top-left";
          # };
          # actions = true;
          # anchor = "top-right";
          # background-color = "#000000";
          # border-color = "#FFFFFF";
          # border-radius = 0;
          default-timeout = 5000;
          # font = "monospace 10";
          # height = 100;
          # icons = true;
          # ignore-timeout = true;
          # layer = "top";
          # margin = 10;
          # markup = true;
          # width = 300;
        };
      };

      # Explicitly set dark theme
      gtk = {
        enable = true;
        theme = {
          name = "Adwaita-dark";
          package = pkgs.gnome-themes-extra;
        };
        gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
        gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
      };
      qt = {
        enable = true;
        platformTheme.name = "adwaita";
        style.name = "adwaita-dark";
      };
    };
  };
}
