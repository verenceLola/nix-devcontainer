{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-public-keys = [
      "hydra:Y+Lzt1kDKarzDwI5fyz3rG3sOd3MIktzJ1DMtLfrD+0="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
    substituters = [
      "https://nix-cache.verencelola.home"
      "https://cache.nixos.org"

    ];
  };
}
