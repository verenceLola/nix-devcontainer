{
  imports = [ ./common.nix ];

  config = { networking = { useDHCP = true; }; };
}
