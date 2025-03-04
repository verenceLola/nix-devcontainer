{ ... }: {
  imports = [
    ./networking.nix
    ./security.nix
    ./services.nix
    ./programs.nix
    ./users.nix
  ];
}
