{ config, ... }: {
  imports = [ ./common.nix ];

  config = {
    networking = {
      useDHCP = true;
      wireless = {
        enable = true;
        secretsFile = config.sops.templates."wireless.conf".path;
        networks = { verenceLola.pskRaw = "ext:psk_verenceLola"; };
      };
    };
  };
}
