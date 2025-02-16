{ lib, modulesPath, ... }: with lib; {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    (modulesPath + "/profiles/all-hardware.nix")
  ];

  system = {
    stateVersion = "25.05";
  };
}

