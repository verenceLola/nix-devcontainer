{ config, pkgs, ... }: {
  config = {
    environment = {
      systemPackages = with pkgs; [
        firefox # Firefox
        direnv # Shell environment
        emacs-pgtk
        kitty # Default terminal
        wayvnc # VNC server
        grimblast # Screenshots
        swaynotificationcenter # Notifications GUI
        pywal16 # color pallets
        pavucontrol # Audio controls
      ];
      etc = {
        ssh-key = {
          user = config.users.users.admin.name;
          group = config.users.users.admin.group;
          mode = "0600";
          target = "ssh/ssh_host_ed25519_key";
          source = ../secrets/ssh.key;
        };
        ssh-public-key = {
          user = "root";
          group = "root";
          mode = "0644";
          target = "ssh/ssh_host_ed25519_key.pub";
          source = config.sops.secrets."ssh/ed25519/pub".path;
        };
        wayvnc = {
          target = "wayvnc/config";
          source = config.sops.templates.wayvnc-config.path;
          mode = "0755";
          group = "video";
        };
      };
    };
  };
}
