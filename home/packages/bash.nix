# Configure bash and setup some aliases.
{ ... }:

{
  programs.bash = {
    enable = true;

    shellAliases = {
      os-rebuild = "sudo nixos-rebuild --flake ~/nixos/#OMEN-Laptop switch";
      config = "code ~/nixos";
    };

    bashrcExtra = ''
      eval "$(direnv hook bash)"
      eval "$(devenv hook bash)"
      eval "$(fzf --bash)"
    '';
  };
}
