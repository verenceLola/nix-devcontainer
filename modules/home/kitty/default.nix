{ ... }: {
  home = {
    file = {
      kitty-config = {
        target = ".config/kitty/kitty.conf";
        source = ./kitty.conf;
      };
      starship-config = {
        target = ".config/starship.toml";
        source = ./starship.toml;
      };
    };
  };
}
