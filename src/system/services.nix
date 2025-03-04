{ config, lib, ... }: with lib; {
  config = {
    services = {
      resolved = {
        enable = true;
      };
    };
    qemuGuest = {
      enable = true;
    };
  };
}
