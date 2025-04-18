let
  startWofi =
    "pidof wofi || wofi -c .config/wofi/config.conf -s .config/wofi/style.css -C .cache/wal/colors";
  lock = "pidof hyprlock || hyprlock";
in [
  "$mod, T, exec, kitty" # Terminal app
  "$mod, E, exec, emacs"
  ", Print, exec, grimblast copy area"
  "$mod, Tab, cyclenext" # change focus to another window
  "$mod, Tab, bringactivetotop" # bring it to the top

  "$mod, Q, killactive"
  "$mod CTRL, F, fullscreen"

  "$mod, V, togglefloating"

  # Wofi
  "$mod, SPACE, exec, ${startWofi}"

  # Lock session
  "$mod CTRL, Q, exec, ${lock}"
] ++ (
  # workspaces
  # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
  builtins.concatLists (builtins.genList (i:
    let ws = i + 1;
    in [
      "$mod, code:1${toString i}, workspace, ${toString ws}"
      "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
    ]) 9))
