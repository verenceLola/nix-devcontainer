{ config, lib, suggestedHostName, ... }:
with lib;
let myHomeDomain = "verencelola.home";
in {
  config = {
    networking = {
      domain = myHomeDomain;
      search = [ myHomeDomain ];
      hostName = suggestedHostName;
      hosts = { "10.0.0.1" = [ "pfsense.${myHomeDomain}" ]; };
      timeServers = [ "pfsense.${myHomeDomain}" ];
      nameservers = [ "10.0.0.1" ];
      firewall = { allowedTCPPorts = [ 5900 ]; };
    };
  };
}
