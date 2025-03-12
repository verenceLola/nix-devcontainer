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
        environmentFile = config.age.secrets.dns-rfc2136.path;
      };
    };
  };
}
