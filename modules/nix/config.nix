{ config, inputs, ... }: {
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
    nixPath = [ "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos" ];
  };

  system = { stateVersion = "24.11"; };
  nixpkgs.overlays = [ (import inputs.emacs-overlay) ];
}
