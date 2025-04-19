{ config, ... }: {
  config = {
    programs = {
      zsh = { enable = true; };
      waybar = { enable = true; };
      starship = { enable = true; };
      ssh = { startAgent = true; };
    };
  };
}
