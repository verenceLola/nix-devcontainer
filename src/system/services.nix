{ config, lib, ... }: with lib; {
  config = {
    services = {
      resolved = {
        enable = true;
      };
      qemuGuest = {
        enable = true;
      };
      openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "yes";
        };
      };
    };
  };
}
