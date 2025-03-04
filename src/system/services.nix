{ config, lib, ... }: with lib; {
  config = {
    services = {
      resolved = {
        enable = true;
      };
    };
  };
}
