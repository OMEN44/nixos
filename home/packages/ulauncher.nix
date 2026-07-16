{ config, pkgs, ... }:

let
  # Wrap ulauncher's own python interpreter with the calculator
  # extension's dependencies. Extensions run under the same
  # interpreter ulauncher itself uses (sys.executable), so adding
  # these to its propagated packages makes them importable without
  # needing `pip install` anywhere.
  ulauncherWithCalc = pkgs.ulauncher.overridePythonAttrs (old: {
    propagatedBuildInputs =
      (old.propagatedBuildInputs or [ ])
      ++ (with pkgs.python3Packages; [
        pint
        simpleeval
        parsedatetime
        pytz
      ]);
  });
in
{
  home.packages = [
    ulauncherWithCalc
    pkgs.wmctrl
  ];

  # home.file.".config/ulauncher".source =
  #  "${config.home.homeDirectory}/nixos/dots/ulauncher-themes/ulauncher";
  home.file.".config/ulauncher/user-themes".source =
    "${config.home.homeDirectory}/nixos/dots/ulauncher-themes/ulauncher/user-themes";
  home.file.".config/ulauncher/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dots/ulauncher-themes/ulauncher/settings.json";

  # Autostart on login via systemd user session.
  systemd.user.services.ulauncher = {
    Unit = {
      Description = "Ulauncher - Application launcher";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${ulauncherWithCalc}/bin/ulauncher --hide-window --no-window-shadow";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
