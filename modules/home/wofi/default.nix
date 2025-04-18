{ ... }: {
  home = {
    file = {
      wofi-config = {
        target = ".config/wofi/config.conf";
        source = ./config.conf;
      };
      wofi-styles = {
        target = ".config/wofi/style.css";
        source = ./style.css;
      };
    };
  };
}
