{ config, inputs, ... }: {
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";

    age = { sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ]; };

    templates = {
      "acme-env-file" = {
        content = ''
          RFC2136_TSIG_KEY=${config.sops.placeholder."dns_rfc2136/key"}
          RFC2136_NAMESERVER=${config.sops.placeholder."dns_rfc2136/nameserver"}
          RFC2136_TSIG_ALGORITHM=${
            config.sops.placeholder."dns_rfc2136/algorithm"
          }
          RFC2136_TSIG_SECRET=${config.sops.placeholder."dns_rfc2136/secret"}
        '';
        owner = "acme";
      };
      "wayvnc-config" = {
        content = ''
          address=0.0.0.0
          enable_auth=true
          relax_encryption=true
          certificate_file=/var/lib/acme/${config.networking.fqdn}/cert.pem
          password=${config.sops.placeholder."vnc/password"}
          username=${config.sops.placeholder."vnc/username"}
          private_key_file=/var/lib/acme/${config.networking.fqdn}/key.pem
        '';
        group = "video";
      };
    };

    secrets = {
      # Nix Config
      "nix/accessTokens/app.gitlab.verencelola.home" = {
        mode = "0440";
        group = "users";
      };

      # DNS Secrets
      "dns_rfc2136/key" = { };
      "dns_rfc2136/nameserver" = { };
      "dns_rfc2136/algorithm" = { };
      "dns_rfc2136/secret" = { };

      # SSh Secrets
      "ssh/ed25519/pub" = { };
      "ssh/ed25519/key" = { };

      # VNC
      "vnc/password" = { };
      "vnc/username" = { };
    };
  };
}
