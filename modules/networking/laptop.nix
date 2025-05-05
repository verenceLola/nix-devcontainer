{ config, ... }: {
  imports = [ ./common.nix ];

  services.blueman = { enable = true; };
  programs = { nm-applet = { enable = true; }; };
  networking = {
    networkmanager = {
      ensureProfiles.profiles = {
        verenceLola = {
          connection = {
            id = "verenceLola";
            type = "wifi";
            autoconnect = true;
          };
          ipv4 = { method = "auto"; };
          ipv6 = { method = "auto"; };
          wifi = {
            mode = "infrastructure";
            ssid = "verenceLola";
          };
          wifi-security = {
            key-mgmt = "wpa-psk";
            psk = config.sops.secrets."wireless/psk_verenceLola".path;
          };
        };
      };
    };
  };
}
