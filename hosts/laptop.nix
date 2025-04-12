{ nixpkgs, home-manager, ... }@inputs:
let
  modulesToInclude = builtins.map (m: ../modules + "/${m}") [
    "hardware/laptop" # Graphics configuration
    "nix" # Nix configuration
    "secrets" # Secrets
    "system" # System defaults
    "users/admin.nix" # Admin user
    "networking/laptop.nix" # Networking
  ];

in nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = modulesToInclude ++ [
    home-manager.nixosModules.home-manager
    { home-manager = import ../modules/home { inherit inputs; }; }
  ];
  specialArgs = {
    suggestedHostName = "laptop";
    inherit inputs;
  };
}
