{ config, lib, suggestedHostName, ... }:
with lib;
let
  cfg = config.features.networking;
  myHomeDomain = "verencelola.home";
in {
  options = {
    features = {
      networking = {
        machineIP = mkOption {
          type = types.str;
          default = "172.16.0.110";
          description = "The IP address of the machine.";
        };
      };
    };
  };

  config = {
    networking = {
      useDHCP = false;
      domain = myHomeDomain;
      search = [ myHomeDomain ];
      hostName = suggestedHostName;
      enableIPv6 = false;
      hosts = { "10.0.0.1" = [ "pfsense.${myHomeDomain}" ]; };
      timeServers = [ "pfsense.${myHomeDomain}" ];
      nameservers = [ "10.0.0.1" ];
      defaultGateway = {
        interface = "eth0";
        address = "172.16.0.1";
      };
      interfaces = {
        eth0 = {
          ipv4 = {
            addresses = [{
              address = cfg.machineIP;
              prefixLength = 24;
            }];
          };
        };
      };
    };
  };
}
