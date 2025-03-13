{ ... }: {
  home = {
    file = {
      wayvnc-config = {
        target = ".config/wayvnc/config";
        text = ''
          address=0.0.0.0
          enable_auth=true
          certificate_file=/var/lib/acme/nixos-20250313.verencelola.home/cert.pem
          password=Platyrhynchos90
          username=admin
          private_key_file=/var/lib/acme/nixos-20250313.verencelola.home/key.pem
        '';
      };
    };
  };
}
