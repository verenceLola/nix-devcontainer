{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-public-keys = [
        "hydra:Y+Lzt1kDKarzDwI5fyz3rG3sOd3MIktzJ1DMtLfrD+0="
      ];
      substituters = [
        "https://nix-cache.verencelola.home"
      ];
      trusted-users = [
        "admin"
      ];
      access-tokens = [
        "app.gitlab.verencelola.home=PAT:glpat-oWEqSzBvvAi4zP2UNUJ3"
      ];
    };
    channel = {
      enable = false;
    };
  };
}
