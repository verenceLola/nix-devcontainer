# `self` here is referring to the flake `self`, you may need to pass it using `specialArgs` or define your NixOS installer configuration
# in the flake.nix itself to get direct access to the `self` flake variable.
{ pkgs, self, nixos, ... }:
let
  dependencies = [
    nixos.config.system.build.toplevel
    nixos.config.system.build.diskoScript
    nixos.config.system.build.diskoScript.drvPath
    pkgs.stdenv.drvPath

    # https://github.com/NixOS/nixpkgs/blob/f2fd33a198a58c4f3d53213f01432e4d88474956/nixos/modules/system/activation/top-level.nix#L342
    pkgs.perlPackages.ConfigIniFiles
    pkgs.perlPackages.FileSlurp

    (pkgs.closureInfo { rootPaths = [ ]; }).drvPath
  ] ++ builtins.map (i: i.outPath) (builtins.attrValues self.inputs);

  closureInfo = pkgs.closureInfo { rootPaths = dependencies; };
in
# Now add `closureInfo` to your NixOS installer
{
  environment.etc."install-closure".source = "${closureInfo}/store-paths";

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "install-nixos-unattended" ''
      set -eux
      # Replace "/dev/disk/by-id/some-disk-id" with your actual disk ID

      exec ${pkgs.disko}/bin/disko-install --flake "${nixos.config.system.build.toplevel}" --disk vdb "/dev/disk/by-id/some-disk-id"
    '')
  ];
}
