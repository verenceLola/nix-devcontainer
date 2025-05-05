{ suggestedHostName, ... }:
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
      enableIPv6 = false;
      networkmanager = {
        enable = true;
        dns = "systemd-resolved";
        dhcp = "dhcpcd";
        wifi = {
          backend = "wpa_supplicant";
          powersave = true;
        };
      };
    };
  };
}
