{ ... }: {
  imports = [ ./common.nix ];

  config = {
    networking = {
      useDHCP = false;
      defaultGateway = {
        interface = "eth0";
        address = "172.16.0.1";
      };
      enableIPv6 = false;
      interfaces = {
        eth0 = {
          ipv4 = {
            addresses = [{
              address = "172.16.0.110";
              prefixLength = 24;
            }];
          };
        };
      };
    };
  };
}
