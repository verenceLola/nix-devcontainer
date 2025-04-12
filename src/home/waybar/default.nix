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
      weather = {
        target = ".config/waybar/scripts/wttr.py";
        source = ./scripts/wttr.py;
        executable = true;
      };
    };
  };
}
