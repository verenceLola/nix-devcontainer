{ config, pkgs, ... }:
let
  profilePicture = pkgs.fetchurl {
    url = "https://avatars.githubusercontent.com/u/38049235?v=4";
    sha256 = "sha256-TF1GWT9fNpdsy/+H72mPAOmr8388fy9GlpPs3pLo66Y=";
  };
in {

  home = {
    username = "admin";
    stateVersion = "25.05";
    homeDirectory = "/home/${config.home.username}";
    file = {
      ssh_private_key = {
        target = ".ssh/id_ed25519";
        source = ../../secrets/ssh.key;
      };
      ssh_public_key = {
        target = ".ssh/id_ed25519.pub";
        text = ''
          ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFTCysy0tCsoiG5aUxqnB2neMlTP/6IQUcYTmh6FOS5u
        '';
      };
      profilePicture = {
        target = "Pictures/profile/admin.png";
        source = profilePicture;
      };
    };
  };
  programs = {
    home-manager.enable = true;
    # TODO: Move this to a more re-usable location
    chromium = { enable = true; };
  };
}
