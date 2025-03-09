{ inputs, pkgs, lib, config, ... }:
with lib; {
  users.users = {
    admin = {
      createHome = true;
      description = "HomeLab Admin";
      extraGroups = [ "wheel" "sudo" ];
      isNormalUser = true;
      group = "users";
      hashedPassword =
        "$2b$05$deRQVKqVPo/XPbWxl9SiFuh3XGVVcgimkXfmnB6E/QWRR5yIka9BK";

      openssh = {
        authorizedKeys = {
          keys = [ config.age.secrets.admin_private_key.path ];
        };
      };
      packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
    };
  };
}
