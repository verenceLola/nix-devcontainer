{ config, lib, ... }:
with lib;
let cfg = config.features.security;
in {
  options = {
    enableSudo = mkEnableOption "Enable Sudo" { default = true; };
    installMyCA = mkEnableOption "Install My CA" { default = true; };
  };

  config = {
    security = {
      pki = {
        certificateFiles = mkIf cfg.installMyCA [
          fetchurl
          {
            url = "https://ca.verencelola.home/roots.pem";
            curlOpts = "-k";
            sha256 = "0d9zi0gh63hk0p3r8apcbjh9l91bi936ijsnsynkby1nqj6fz7km";
            name = "verenceLola-Inc.pem";
          }
        ];
      };
    };
  };
}
