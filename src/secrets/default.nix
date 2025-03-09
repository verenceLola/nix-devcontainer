{ config, lib, ... }: {
  imports = [ ./ssh.nix ];

  age = {
    identityPaths = [
      (lib.lists.findFirst (x: x.type == "rsa") "/etc/ssh/ssh_host_rsa_key"
        config.services.openssh.hostKeys).path
    ];
  };
}
