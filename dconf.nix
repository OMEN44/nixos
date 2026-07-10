# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "ca/desrt/dconf-editor" = {
      saved-pathbar-path = "/org/gnome/shell/app-picker-layout";
      saved-view = "/org/gnome/shell/app-picker-layout";
      window-height = 500;
      window-is-maximized = false;
      window-width = 540;
    };

    "org/gnome/Console" = {
      ignore-scrollback-limit = true;
      last-window-maximised = true;
      last-window-size = mkTuple [ 1052 456 ];
    };

    "org/gnome/control-center" = {
      last-panel = "applications";
      window-state = mkTuple [ 980 640 false ];
    };

    "org/gnome/desktop/app-folders" = {
      folder-children = [ "System" "Utilities" "YaST" "Pardus" ];
    };

    "org/gnome/desktop/app-folders/folders/Pardus" = {
      categories = [ "X-Pardus-Apps" ];
      name = "X-Pardus-Apps.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/System" = {
      apps = [ "org.gnome.baobab.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.Logs.desktop" "org.gnome.SystemMonitor.desktop" ];
      name = "X-GNOME-Shell-System.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/Utilities" = {
      apps = [ "org.gnome.Decibels.desktop" "org.gnome.Connections.desktop" "org.gnome.Papers.desktop" "org.gnome.font-viewer.desktop" "org.gnome.Loupe.desktop" "org.gnome.seahorse.Application.desktop" ];
      name = "X-GNOME-Shell-Utilities.directory";
      translate = true;
    };

    "org/gnome/desktop/app-folders/folders/YaST" = {
      categories = [ "X-SuSE-YaST" ];
      name = "suse-yast.directory";
      translate = true;
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/drool-l.svg";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/drool-d.svg";
      primary-color = "#86b6ef";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/break-reminders/eyesight" = {
      play-sound = true;
    };

    "org/gnome/desktop/break-reminders/movement" = {
      duration-seconds = mkUint32 300;
      interval-seconds = mkUint32 1800;
      play-sound = true;
    };

    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "au" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-animations = true;
      show-battery-percentage = true;
      toolkit-accessibility = false;
    };

    "org/gnome/desktop/notifications" = {
      application-children = [ "code" "gnome-power-panel" "gnome-about-panel" "vivaldi-stable" "discord" "org-gnome-console" ];
    };

    "org/gnome/desktop/notifications/application/code" = {
      application-id = "code.desktop";
    };

    "org/gnome/desktop/notifications/application/discord" = {
      application-id = "discord.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-about-panel" = {
      application-id = "gnome-about-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/gnome-power-panel" = {
      application-id = "gnome-power-panel.desktop";
    };

    "org/gnome/desktop/notifications/application/org-gnome-console" = {
      application-id = "org.gnome.Console.desktop";
    };

    "org/gnome/desktop/notifications/application/ulauncher" = {
      application-id = "ulauncher.desktop";
    };

    "org/gnome/desktop/notifications/application/vivaldi-stable" = {
      application-id = "vivaldi-stable.desktop";
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/drool-l.svg";
      primary-color = "#86b6ef";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/search-providers" = {
      sort-order = [ "org.gnome.Settings.desktop" "org.gnome.Contacts.desktop" "org.gnome.Nautilus.desktop" ];
    };

    "org/gnome/nautilus/preferences" = {
      migrated-gtk-settings = true;
    };

    "org/gnome/nautilus/window-state" = {
      initial-size = mkTuple [ 890 550 ];
      initial-size-file-chooser = mkTuple [ 890 550 ];
    };

    "org/gnome/portal/filechooser/org/chromium/Chromium" = {
      last-folder-path = "/home/huon/projects/roar-docs-old";
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-schedule-automatic = false;
    };

    "org/gnome/settings-daemon/plugins/housekeeping" = {
      donation-reminder-last-shown = mkInt64 1783216502744944;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Control><Alt>t";
      command = "kgx";
      name = "Console";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>f";
      command = "nautilus";
      name = "Files";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "Menu";
      command = "ulauncher-toggle";
      name = "Ulauncher";
    };

    "org/gnome/shell" = {
      disabled-extensions = [ "dash-to-panel@jderose9.github.com" ];
      enabled-extensions = [ "blur-my-shell@aunetx" "clipboard-indicator@tudmotu.com" "user-theme@gnome-shell-extensions.gcampax.github.com" "just-perfection-desktop@just-perfection" "color-picker@tuberry" "dash-to-dock@micxgx.gmail.com" ];
      favorite-apps = [ "vivaldi-stable.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Console.desktop" ];
      welcome-dialog-last-shown-version = "50.1";
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/shell/extensions/appindicator" = {
      icon-brightness = 0.0;
      icon-contrast = 0.0;
      icon-opacity = 240;
      icon-saturation = 0.0;
      icon-size = 4;
      tray-pos = "center";
    };

    "org/gnome/shell/extensions/blur-my-shell" = {
      rounded-blur-found = false;
      settings-version = 2;
    };

    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      brightness = 0.6;
      sigma = 30;
      static-blur = true;
      style-dash-to-dock = 0;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      brightness = 0.6;
      corner-radius = 0;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/window-list" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/clipboard-indicator" = {
      history-size = 50;
      keep-selected-on-clear = true;
      open-at-cursor = true;
      paste-on-select = true;
      regex-search = true;
      show-private-mode = false;
      strip-text = true;
      toggle-menu = [ "<Super>v" ];
    };

    "org/gnome/shell/extensions/color-picker" = {
      color-history = [ (mkUint32 12592440) ];
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      always-center-icons = false;
      apply-custom-theme = false;
      background-opacity = 1.0;
      click-action = "focus-minimize-or-previews";
      dash-max-icon-size = 48;
      dock-fixed = true;
      dock-position = "BOTTOM";
      extend-height = true;
      height-fraction = 0.9;
      hide-tooltip = false;
      multi-monitor = true;
      preferred-monitor = -2;
      preferred-monitor-by-connector = "HDMI-1";
      preview-size-scale = 0.0;
      running-indicator-style = "DOTS";
      show-apps-always-in-the-edge = true;
      show-mounts = false;
      show-trash = false;
      transparency-mode = "DEFAULT";
    };

    "org/gnome/shell/extensions/dash-to-panel" = {
      dot-position = "BOTTOM";
      dot-style-focused = "DOTS";
      dot-style-unfocused = "DOTS";
      extension-version = 73;
      group-apps = true;
      hotkeys-overlay-combo = "TEMPORARILY";
      panel-anchors = ''
        {"PHL-AU02036016470":"MIDDLE","CMN-0x00000000":"MIDDLE"}\\\\\\\\n\\\\n\\n\n
      '';
      panel-element-positions = ''
        {}\\\\\\\\n\\\\n\\n\n
      '';
      panel-lengths = ''
        {"PHL-AU02036016470":100,"CMN-0x00000000":100}\\\\\\\\n\\\\n\\n\n
      '';
      panel-positions = ''
        {}\\\\\\\\n\\\\n\\n\n
      '';
      panel-sizes = ''
        {}\\\\\\\\n\\\\n\\n\n
      '';
      prefs-opened = false;
      stockgs-keep-dash = false;
      stockgs-keep-top-panel = false;
      trans-use-custom-opacity = true;
      trans-use-dynamic-opacity = false;
      window-preview-title-position = "TOP";
    };

    "org/gnome/shell/extensions/just-perfection" = {
      panel = true;
      support-notifier-showed-version = 36;
      support-notifier-type = 0;
    };

    "org/gnome/shell/keybindings" = {
      toggle-message-tray = [ "<Alt><Super>v" ];
    };

    "org/gnome/shell/world-clocks" = {
      locations = [];
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
    };

  };
}
