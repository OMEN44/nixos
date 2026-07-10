{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Gnome extensions
    dconf2nix
    dconf-editor
    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    gnomeExtensions.dash-to-dock
    gnomeExtensions.dash-to-panel
    gnomeExtensions.user-themes
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.color-picker
  ];
}