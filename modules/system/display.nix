{ inputs, config, pkgs, ... }: {
  config = {
    programs.hyprland = {
      enable = true;
      # set the flake package
      withUWSM = true;
      package =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # make sure to also set the portal package, so that they are in sync
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    services = {
      seatd = {
        enable = true;
        group = "video";
      };
      #   displayManager = { sddm.enable = true; };
      #   xserver = {
      #     enable = true;
      #     desktopManager = { plasma5.enable = true; };
      #   };
      #   xrdp = {
      #     enable = true;
      #     defaultWindowManager = "startplasma-x11";
      #     openFirewall = true;
      #   };
    };
  };
}
