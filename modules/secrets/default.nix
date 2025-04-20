{ config, pkgs, inputs, ... }:
let
  myRootCa = pkgs.fetchurl {
    url = "https://ca.verencelola.home/roots.pem";
    curlOpts = "-k";
    sha256 = "0d9zi0gh63hk0p3r8apcbjh9l91bi936ijsnsynkby1nqj6fz7km";
  };
in {
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
      "wireless.conf" = {
        content = ''
          psk_verenceLola=${config.sops.placeholder."wireless/psk_verenceLola"}
        '';
      };
      "git-credentials" = {
        content = ''
          [credential]
          username = ${config.sops.placeholder."me/git_username"}

          [http "https://*.verencelola.home"]
          sslVerify = true
          sslCaPath = ${myRootCa}

          [user]
          name = ${config.sops.placeholder."me/name"}
          email = ${config.sops.placeholder."me/email"}
        '';
        owner = "admin";
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

      # SSH Secrets
      "ssh/ed25519/pub" = { };
      "ssh/ed25519/key" = { };

      # GPG
      "gpg/private_key" = { owner = "admin"; };
      "gpg/passphrase" = { owner = "admin"; };

      # ME
      "me/name" = { };
      "me/email" = { };
      "me/git_username" = { };

      # VNC
      "vnc/password" = { };
      "vnc/username" = { };

      # Wireless
      "wireless/psk_verenceLola" = { };
    };
  };
}
