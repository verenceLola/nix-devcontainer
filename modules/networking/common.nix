{ config, lib, suggestedHostName, ... }:
with lib;
let
  myHomeDomain = "verencelola.home";
  myGateway = "pfsense.${myHomeDomain}";
in {
  config = {
    networking = {
      domain = myHomeDomain;
      search = [ myHomeDomain ];
      hostName = suggestedHostName;
      hosts = { "10.0.0.1" = [ myGateway ]; };
      timeServers = [ myGateway ];
      nameservers = [ "10.0.0.1" ];
      firewall = { allowedTCPPorts = [ 5900 ]; };
    };
  };
}
