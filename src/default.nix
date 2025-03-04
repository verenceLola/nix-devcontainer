{ lib, modulesPath, ... }: with lib; {

  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")

    ./hardware # Hardware

    ./nix # Nix configuration

    ./secrets # Secrets

    ./system # System Defaults

    ./users/admin.nix # Admin User
  ];

  system = {
    stateVersion = "25.05";
  };
}
