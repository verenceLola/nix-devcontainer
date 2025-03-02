{ self, config, pkgs, lib, modulesPath, ... }:
let
  installer = pkgs.writeShellApplication {
    name = "installer";
    runtimeInputs = with pkgs; [
      disko
    ];
    text = ''
      set -euo pipefail

      ${pkgs.disko}/bin/disko-install --flake ${self}#nixos --disk main /dev/sda
      echo "Done! Rebooting..."
      sleep 3
      reboot
    '';
  };
  installerFailsafe = pkgs.writeShellScript "failsafe" ''
    ${lib.getExe installer} || echo "ERROR: Installation failure!"
    sleep 3600
  '';
in
{
  imports = [
    (modulesPath + "/installer/cd-dvd/iso-image.nix")
    (modulesPath + "/profiles/all-hardware.nix")
  ];

  boot.kernelParams = [ "systemd.unit=getty.target" ];

  console = {
    earlySetup = true;
    font = "ter-v16n";
    packages = [ pkgs.terminus_font ];
  };

  isoImage.isoName = "${config.isoImage.isoBaseName}-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}.iso";
  isoImage.makeEfiBootable = true;
  isoImage.makeUsbBootable = true;
  isoImage.squashfsCompression = "zstd -Xcompression-level 15"; # xz takes forever

  systemd.services."getty@tty1" = {
    overrideStrategy = "asDropin";
    serviceConfig = {
      ExecStart = [ "" installerFailsafe ];
      Restart = "no";
      StandardInput = "null";
    };
  };

  system.stateVersion = "24.05";
}
