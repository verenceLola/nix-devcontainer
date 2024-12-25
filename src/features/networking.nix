{ config, lib, ... }: with lib;
let
  cfg = config.features.networking;
in
{
  options =
    {
      networking = {
        machineIP = mkOption {
          type = types.str;
        };
        domain = mkOption {
          type = types.str;
          default = "verencelola.home";
          description = "The domain name for the network";
        };
      };
    };

  config = {
    networking = {
      useDHCP = false;
      domain = config.networking.domain;
      enableIPv6 = false;
      hosts = {
        "10.0.0.1" = [ "pfsense.verencelola.home" ];
      };
      timeServers = [
        "pfsense.verencelola.home"
      ];
      nameservers = [
        "pfsense.verencelola.home"
      ];
      interfaces = {
        eth0 = {
          ipv4 = {
            addresses = [
              {
                address = cfg.machineIP;
                prefixLength = 32;
              }
            ];
          };
        };
      };
    };
  };
}
