{ pkgs, config, ... }:
let
  myRootCa = pkgs.fetchurl {
    url = "https://ca.verencelola.home/roots.pem";
    curlOpts = "-k";
    sha256 = "0d9zi0gh63hk0p3r8apcbjh9l91bi936ijsnsynkby1nqj6fz7km";
  };
in {
  security = {
    pki = { certificateFiles = [ myRootCa ]; };
    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (
            subject.isInGroup("users")
              && (
                action.id == "org.freedesktop.login1.reboot" ||
                action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
                action.id == "org.freedesktop.login1.power-off" ||
                action.id == "org.freedesktop.login1.power-off-multiple-sessions"
              )
            )
          {
            return polkit.Result.YES;
          }
        });
      '';
    };
    acme = {
      acceptTerms = true;
      preliminarySelfsigned = false;
      defaults = {
        server = "https://ca.verencelola.home/acme/acme/directory";
        renewInterval = "daily";
        email = "acme@verencelola.com";
        dnsProvider = "rfc2136";
        environmentFile = config.sops.templates.acme-env-file.path;
      };
      certs = {
        "${config.networking.fqdn}" = {
          group = "users";
          enableDebugLogs = true;
          dnsPropagationCheck = false;
        };
      };
    };
    sudo = {
      extraRules = [{
        users = [ config.users.users.admin.name ];
        commands = [{
          command = "ALL";
          options = [ "NOPASSWD" ];
        }];
      }];
    };
  };
  programs = { gnupg = { agent = { enable = true; }; }; };
  system = {
    userActivationScripts = {
      importGPGKeys = let gpg = "${pkgs.gnupg}/bin/gpg";
      in {
        text = ''
          ${gpg} --batch --passphrase-file ${
            config.sops.secrets."gpg/passphrase".path
          } --import ${config.sops.secrets."gpg/private_key".path}

          ${pkgs.curl}/bin/curl https://keybase.io/verencelola/pgp_keys.asc | ${gpg} --import

          # Trust above key
          echo "trust\n4\nquit" | ${gpg} --command-fd 0 --no-tty --edit-key B93916FD19F86056636CA9479BD70668EC04D878
        '';
      };
    };
  };
}
