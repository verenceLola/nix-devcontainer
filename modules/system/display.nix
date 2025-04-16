{ inputs, config, pkgs, ... }: {
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
    };
  };
}
