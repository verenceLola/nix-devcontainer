{ inputs, ... }: {
  useGlobalPkgs = true;
  useUserPackages = true;
  users = { admin = import ../home/admin; };
  extraSpecialArgs = { inherit inputs; };
  sharedModules =
    [ ./hyprland ./swaync ./waybar ./swww ./hyprlock ./hypridle ./wofi ];
}
