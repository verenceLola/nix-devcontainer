{ lib, ... }@inputs:
let sops = inputs.nixosConfig.sops;
in {
  home = {
    file = {
      git-config = {
        target = ".config/git/config";
        source = ./config.ini;
      };
      git-credentials = {
        target = ".config/git/credentials";
        text = lib.generators.toINI { } {
          include = { path = sops.templates."git-credentials".path; };
        };
      };
    };
  };
}
