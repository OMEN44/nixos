# configure rofi
{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    # Add any additional configuration options for rofi here
  };
}