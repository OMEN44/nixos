{ pkgs, ... }:
let
  kicad = pkgs.kicad.overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.makeWrapper ];
    postInstall = (old.postInstall or "") + ''
      wrapProgram $out/bin/kicad \
        --set GDK_BACKEND x11 \
        --unset WAYLAND_DISPLAY
    '';
  });
in
{
  home.packages = [
    kicad
  ];
}
