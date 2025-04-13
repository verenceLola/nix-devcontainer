{ config, ... }: {
  config = {
    programs = {
      zsh = { enable = true; };
      waybar = { enable = true; };

      ssh = { startAgent = true; };
    };
  };
}
