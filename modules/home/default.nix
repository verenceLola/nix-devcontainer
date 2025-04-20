{ inputs, ... }: {
  useGlobalPkgs = true;
  useUserPackages = true;
  users = { admin = import ../home/admin; };
  extraSpecialArgs = { inherit inputs; };
  sharedModules = [
    ./hyprland
    ./swaync
    ./kitty
    ./waybar
    ./swww
    ./hyprlock
    ./hypridle
    ./wofi
    ./git
  ];
}
