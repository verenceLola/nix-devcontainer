{ nixosConfig, ... }:
let opacity-transparent = 0.7;
in {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      "$mod" = "SUPER";
      "exec-once" = [
        "uwsm app -- wayvnc -C /etc/${nixosConfig.environment.etc.wayvnc.target} -f 120 --gpu"
        "uwsm app -- swaync -c .config/swaync/config.json -s .config/swaync/style.css"
      ];
      "exec-shutdown" = "uwsm app -- wayvncctl wayvnc-exit";
      layerrule = [
        "blur, swaync-control-center"
        "blur, swaync-notification-window"
        "ignorezero, swaync-control-center"
        "ignorezero, swaync-notification-window"
        "ignorealpha 0.5, swaync-control-center"
        "ignorealpha 0.5, swaync-notification-window"
      ];
      bind = [
        "$mod, K, exec, kitty" # Terminal app
        "$mod, E, exec, emacs"
        ", Print, exec, grimblast copy area"
        "$mod, Tab, cyclenext" # change focus to another window
        "$mod, Tab, bringactivetotop" # bring it to the top

        "$mod, W, killactive"
        "$mod CTRL, F, fullscreen"
      ] ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]) 9));
      general = {
        border_size = 2;
        gaps_in = 2;
        gaps_out = 5;
        "col.active_border" = "0xffffff38";
        layout = "dwindle";
        resize_on_border = true;

        snap = { enabled = true; };
      };
      decoration = {
        rounding = 3;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = opacity-transparent;
        dim_inactive = true;
      };
      animations = {
        enabled = true;
        first_launch_animation = true;
      };
      input = {
        natural_scroll = true;
        follow_mouse = 2;
        repeat_rate = 50;
        repeat_delay = 500;

        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
          tap-to-click = true;
          tap-and-drag = true;
          drag_lock = true;
        };
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_create_new = true;
      };
      binds = {
        allow_workspace_cycles = true;
        workspace_center_on = 1;
      };
      cursor = {
        inactive_timeout = 300;
        enable_hyprcursor = true;
      };
    };
  };
}
