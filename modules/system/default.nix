{ ... }: {
  imports = [
    ./security.nix
    ./services.nix
    ./programs.nix
    ./users.nix
    ./display.nix
    ./environment.nix
    ./fonts.nix
    ./audio.nix
  ];
}
