{ self, nixpkgs, disko, home-manager, ... }@inputs:
let
  suggestedHostName = "nixos-${builtins.substring 0 8 self.lastModifiedDate}";

  modulesToInclude = builtins.map (m: ../modules + "/${m}") [
    "hardware"
    "nix"
    "secrets"
    "system"
    "users/admin.nix"
    "networking/vm.nix"
  ];

in nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = modulesToInclude ++ [
    disko.nixosModules.disko
    home-manager.nixosModules.home-manager
    { home-manager = import ../modules/home { inherit inputs; }; }
  ];
  specialArgs = {
    suggestedHostName = suggestedHostName;
    inherit inputs;
  };
}
