{ config, ... }: {
  config = {
    programs = {
      zsh = { enable = true; };
      waybar = { enable = true; };
    };
  };
}
