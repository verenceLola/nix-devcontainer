{ self, nixpkgs, ... }:
with nixpkgs.lib.attrsets;
let
  isoJobs = mapAttrs' (name: value:
    nameValuePair "${name}-iso-installer" (import ./iso.nix {
      inherit self nixpkgs;
      targetSystem = value;
    })) self.nixosConfigurations;
  nixosJobs = mapAttrs' (name: value:
    nameValuePair "${name}-os" (value.config.system.build.toplevel))
    self.nixosConfigurations;
in mergeAttrsList [ nixosJobs isoJobs ]
