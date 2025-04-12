{ self, nixpkgs, targetSystem, ... }:
let
  system = "x86_64-linux";
  builtSystem = nixpkgs.lib.nixosSystem {
    system = system;
    specialArgs = { targetSystem = targetSystem; };
    modules = [ ../modules/installer ];
  };
  version = "${builtins.substring 0 8 (self.lastModifiedDate or "19700101")}.${
      self.shortRev or "DIRTY"
    }";

in builtSystem.config.system.build.isoImage.overrideAttrs {
  name = "nixos-${version}.iso";
}
