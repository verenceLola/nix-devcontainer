{ modulesPath, ... }: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk.nix
    ./boot.nix
    ./common/graphics.nix
  ];
}
