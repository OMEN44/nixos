{ pkgs, ... }:
let
  shellExtensions = with pkgs.gnomeExtensions; [
    # Gnome extensions
    blur-my-shell
    just-perfection
    dash-to-dock
    dash-to-panel
    user-themes
    clipboard-indicator
    color-picker
    rounded-window-corners-reborn
    top-bar-organizer
    dynamic-music-pill
    open-bar
    astra-monitor
    advanced-alttab-window-switcher
    tray-icons-reloaded
  ];
in
{
  home.packages =
    with pkgs;
    [
      cava # This is for the dynamic-music-pill extension
      dconf2nix
      dconf-editor
      orchis-theme
    ]
    ++ shellExtensions;
}
