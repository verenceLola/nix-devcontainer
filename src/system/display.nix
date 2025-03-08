{ config, ... }: {
  config = {
    services = {
      displayManager = {
        sddm.enable = true;
      };
      xserver = {
        enable = true;
        desktopManager = {
          plasma5.enable = true;
        };
      };
      xrdp = {
        enable = true;
        defaultWindowManager = "startplasma-x11";
        openFirewall = true;
      };
    };
  };
}
