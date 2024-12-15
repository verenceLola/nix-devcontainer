{ config }: with lib; {
  users.users = {
    coder = {
      createHome = true;
      description = "User for the Environment";
      extraGroups = [
        "wheel"
        "sudo"
      ];
      group = "users";
      home = "home/coder";
      uid = 1000;
      shell = "/bin/sh";

      openssh = {
        authorizedKeys = {
          keys = [ ];
        };
      };
    };
    admin = {
      createHome = true;
      description = "System Admin";
      extraGroups = [
        "wheel"
        "sudo"
      ];
      group = "admin";
      home = "/home/admin";
      openssh = {
        authorizedKeys = {
          keys = [
            config.age.secrets.gnupg.path
          ];
        };
      };
    };
  };
}
