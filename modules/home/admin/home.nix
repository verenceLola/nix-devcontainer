{ config, ... }: {
  imports = [ ../swaync ../waybar ];

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
    };
  };
  programs.home-manager.enable = true;
}
