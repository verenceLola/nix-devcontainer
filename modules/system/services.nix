{ config, pkgs, lib, ... }:
with lib; {
  config = {
    services = {
      resolved = { enable = true; };
      qemuGuest = { enable = true; };
      openssh = {
        enable = true;
        settings = { PermitRootLogin = "yes"; };
      };
      pipewire = { enable = true; }; # Audio and Video capture
    };
    systemd = {
      user.services = {
        waybar = {
          enable = true;
          path = [
            (pkgs.python3.withPackages (p: with p; [ requests ]))
            pkgs.busybox
          ];
        };
      };
    };
  };
}
