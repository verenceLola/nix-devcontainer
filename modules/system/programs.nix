{ ... }: {
  config = {
    programs = {
      zsh = { enable = true; };
      waybar = { enable = true; };
      starship = { enable = true; };
      ssh = { startAgent = true; };
      nix-ld = { enable = true; };
    };
  };
}
