{ nixosConfig, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      "$mod" = "SUPER";
      "exec-once" =
        "uwsm app -- wayvnc -C /etc/${nixosConfig.environment.etc.wayvnc.target} -f 120 --gpu";
      "exec-shutdown" = "uwsm app -- wayvncctl wayvnc-exit";
      "debug:disable_logs" = false;
      bind = [ "$mod, F, exec, kitty" ", Print, exec, grimblast copy area" ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]) 9));
    };
  };
}
