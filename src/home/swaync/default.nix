{ ... }: {
  home = {
    file = {
      swayncConfig = {
        target = ".config/swaync/config.json";
        source = ./config.json; # https://github.com/elifouts/Dotfiles/tree/main
      };
      swayncConfigSchema = {
        target = ".config/swaync/configSchema.json";
        source = ./configSchema.json;
      };
      swayncStyles = {
        target = ".config/swaync/style.css";
        source = ./style.css;
      };
    };
  };
}
