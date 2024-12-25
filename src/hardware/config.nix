{ lib, modulesPath, ... }: with lib; {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  system = {
    stateVersion = "25.05";
  };

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = false;
  boot.initrd.availableKernelModules = [
    "ata_piix"
    "uhci_hcd"
    "virtio_pci"
    "virtio_scsi"
    "sd_mod"
    "sr_mod"
  ];
  boot.loader.grub.useOSProber = true;
  boot.loader.systemd-boot.enable = false;

  boot.initrd.kernelModules = [ ];
  boot.loader.efi.canTouchEfiVariables = false;
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  boot.loader.grub.device = "nodev";
}

