{ nixosConfig, ... }:
let opacity-transparent = 1.0;

in {
  home = {
    file = {
      uwsm-hyprland-env = {
        target = ".config/uwsm/env-hyprland";
        text = ''
          export NIXOS_OZONE_WL=1
          export HYPRCURSOR_THEME=rose-pine-hyprcursor
        '';
      };
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      "$mod" = "SUPER";
      "source" = [ "./colors-hyprland.conf" ];
      "exec-once" = [
        "uwsm app -- hyprlock" # Start hyprlock immediately  for login screen
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
      bind = import ./binds.nix;
      general = {
        border_size = 1;
        gaps_in = 2;
        gaps_out = 5;
        "col.active_border" = "$color1";
        "col.inactive_border" = "$background";
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
