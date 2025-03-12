{ ... }: {
  home = {
    file = {
      wayvnc-config = {
        target = ".config/wayvnc/config";
        text = ''
          address=0.0.0.0
        '';
      };
    };
  };
}
