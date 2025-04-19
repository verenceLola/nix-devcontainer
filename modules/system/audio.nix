{ config, ... }: {
  config = {
    services = {
      pipewire = {
        enable = true;
        audio = { enable = true; };
      };
    };
  };
}
