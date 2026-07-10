{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/shell/extensions/rounded-window-corners-reborn" = lib.mkForce {
      blacklist = [ "ulauncher" ];
      border-width = 0;

      global-rounded-corner-settings = [
        (mkDictionaryEntry [ "padding" (mkVariant [
          (mkDictionaryEntry [ "left"   (mkUint32 0) ])
          (mkDictionaryEntry [ "right"  (mkUint32 0) ])
          (mkDictionaryEntry [ "top"    (mkUint32 0) ])
          (mkDictionaryEntry [ "bottom" (mkUint32 0) ])
        ]) ])
        (mkDictionaryEntry [ "keepRoundedCorners" (mkVariant [
          (mkDictionaryEntry [ "maximized"  false ])
          (mkDictionaryEntry [ "fullscreen" false ])
        ]) ])
        (mkDictionaryEntry [ "borderRadius" (mkVariant (mkUint32 15)) ])
        (mkDictionaryEntry [ "smoothing"    (mkVariant 0.3) ])
        (mkDictionaryEntry [ "borderColor"  (mkVariant (mkTuple [
          0.48627451062202454
          0.9921568632125854
          0.9960784316062927
          1.0
        ])) ])
        (mkDictionaryEntry [ "enabled" (mkVariant true) ])
      ];

      settings-version = mkUint32 9;
      skip-libadwaita-app = false;
    };
  };
}