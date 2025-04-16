{ lib, pkgs, ... }:
let
  getBatteryLevel = pkgs.writeShellApplication {
    name = "battery";
    text = lib.readFile ./scripts/battery.sh;
  };
in {
  home = {
    file = {
      hyprlock = {
        target = ".config/hypr/hyprlock.conf";
        source = ./hyprlock.conf;
      };
      "scripts/battery" = {
        target = ".config/hypr/scripts/battery.sh";
        source = "${getBatteryLevel}/bin/battery";
      };
    };
  };
}
