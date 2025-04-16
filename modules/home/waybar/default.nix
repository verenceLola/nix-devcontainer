{ ... }: {
  home = {
    file = {
      waybarConfig = {
        target = ".config/waybar/config.jsonc";
        source = ./config.jsonc;
      };
      waybarStyles = {
        target = ".config/waybar/style.css";
        source = ./style.css;
      };
    };
  };
}
