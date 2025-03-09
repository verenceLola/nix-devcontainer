{ config, lib, ... }:
with lib;
let cfg = config.features.networking;
in {
  options = {
    features = {
      networking = {
        machineIP = mkOption {
          type = types.str;
          default = "172.16.0.109";
          description = "The IP address of the machine.";
        };
      };
    };
  };

  config = {
    networking = {
      useDHCP = false;
      domain = "verencelola.home";
      enableIPv6 = false;
      hosts = { "10.0.0.1" = [ "pfsense.verencelola.home" ]; };
      timeServers = [ "pfsense.verencelola.home" ];
      nameservers = [ "pfsense.verencelola.home" ];
      interfaces = {
        eth0 = {
          ipv4 = {
            addresses = [{
              address = cfg.machineIP;
              prefixLength = 32;
            }];
          };
        };
      };
    };
  };
}
