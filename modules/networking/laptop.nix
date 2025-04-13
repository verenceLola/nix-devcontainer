{
  imports = [ ./common.nix ];

  config = {
    networking = {
      useDHCP = true;
      wireless = { enable = true; };
    };
  };
}
