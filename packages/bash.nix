# Configure bash and setup some aliases.
{ config, pkgs, ... }:

{
  bash = {
    enable = true; 

    shellAliases = {
      os-rebuild = "sudo nixos-rebuild switch";
    };
  };
}