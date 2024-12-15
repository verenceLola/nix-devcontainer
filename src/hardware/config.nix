{ lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  system = {
    stateVersion = "25.05";
  };

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
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
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/d57180d7-e888-4689-8ad6-74b50ba598ae";
      fsType = "ext4";
    };

  boot.loader.grub.device = "nodev";
}

