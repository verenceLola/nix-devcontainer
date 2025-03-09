{ lib, ... }:
with lib; {
  users.users = {
    programmer = {
      createHome = true;
      description = "User for programming";
      extraGroups = [ "wheel" ];
      group = "users";
      useDefaultShell = true;

      openssh = {
        authorizedKeys = { keys = [ config.age.secrets.ssh_public_key.path ]; };
      };
    };
  };
}
