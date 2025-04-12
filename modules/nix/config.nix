{ config, ... }: {
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-public-keys =
        [ "hydra:Y+Lzt1kDKarzDwI5fyz3rG3sOd3MIktzJ1DMtLfrD+0=" ];
      substituters = [ "https://nix-cache.verencelola.home" ];
      trusted-users = [ "admin" ];
    };
    channel = { enable = false; };
    extraOptions = ''
      !include ${
        config.sops.secrets."nix/accessTokens/app.gitlab.verencelola.home".path
      }
    '';
  };

  system = { stateVersion = "25.05"; };
}
