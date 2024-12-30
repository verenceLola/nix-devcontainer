{ lib, config, ... }: with lib; {
  users.users = {
    admin = {
      createHome = true;
      description = "HomeLab Admin";
      extraGroups = [
        "wheel"
      ];
      group = "users";
      hashedPassword = "$2b$05$deRQVKqVPo/XPbWxl9SiFuh3XGVVcgimkXfmnB6E/QWRR5yIka9BK";
      useDefaultShell = true;

      openssh = {
        authorizedKeys = {
          keys = [
            config.age.secrets.ssh_public_key.path
          ];
        };
      };
    };
  };
}
