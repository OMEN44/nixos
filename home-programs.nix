{ config, pkgs, ... }:

{
  inherit ((import ./packages/bash.nix) {config = config; pkgs = pkgs;}) bash;
  inherit ((import ./packages/git.nix) {config = config; pkgs = pkgs;}) git;
  inherit ((import ./packages/rofi.nix) {config = config; pkgs = pkgs;}) rofi;
}