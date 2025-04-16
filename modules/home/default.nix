{ inputs, ... }: {
  useGlobalPkgs = true;
  useUserPackages = true;
  users = { admin = import ../home/admin; };
  extraSpecialArgs = { inherit inputs; };
  sharedModules = [ ./hyprland.nix ./swaync ./waybar ./swww ./hyprlock ];
}
