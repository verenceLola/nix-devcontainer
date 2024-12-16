{ pkgs, ... }:
let
  myRootCa = pkgs.fetchurl {
    url = "https://ca.verencelola.home/roots.pem";
    curlOpts = "-k";
    sha256 = "0d9zi0gh63hk0p3r8apcbjh9l91bi936ijsnsynkby1nqj6fz7km";
  };
in
{
  security = {
    pki = {
      certificateFiles = [
        myRootCa
      ];
    };
  };
}
