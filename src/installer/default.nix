{ self, pkgs, system, ... }: {
  imports = [
    ../nix/config.nix
    ../system/security.nix
    ../features/networking.nix
  ];

  systemd.services =
    {
      install-nixos = {
        enable = true;
        description = "Install NixOS using Disko";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          ExecStartPre = "-${pkgs.disko}/bin/disko-install --flake ${self}#nixos --disk main /dev/sda";
          ExecStart = "reboot now";
          Restart = "no";
          Type = "oneshot";
        };
        unitConfig = {
          After = "network-online.target";
          Requires = [ "network-online.target" ];
        };
      };
    };

  system.stateVersion = pkgs.lib.version;
  services.getty.autologinUser = "root";
}
