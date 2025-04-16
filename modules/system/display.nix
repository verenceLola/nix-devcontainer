{ lib, inputs, config, pkgs, ... }:
let
  startHyprlandUsingUWSM = pkgs.writeShellApplication {
    name = "start-hyprland";
    runtimeInputs = [ pkgs.uwsm ];
    text = ''
      exec uwsm start default
    '';
  };
in {
  config = {
    environment = { systemPackages = with pkgs; [ swww brightnessctl ]; };
    programs = {
      hyprland = {
        enable = true;
        # set the flake package
        withUWSM = true;
        package =
          inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        # make sure to also set the portal package, so that they are in sync
        portalPackage =
          inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };
      hyprlock = {
        enable = true;
        package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;
      };
    };
    services = {
      seatd = {
        enable = true;
        group = "video";
      };
      hypridle = { enable = true; };
      greetd = {
        enable = true;
        settings = {
          default_session = {
            # the predicate here is true since I just need a function with the default
            user = (lib.findFirst (_n: true) { name = "nobody"; }
              (lib.filter (u: u.value.isNormalUser)
                (lib.attrsToList config.users.users))).name;
            command = "${startHyprlandUsingUWSM}/bin/start-hyprland";
          };
        };
      };
    };
  };
}
