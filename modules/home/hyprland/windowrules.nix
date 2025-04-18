{
  # Workspaces
  "$coding" = "2";
  "$browsing" = "3";

  windowrule = [
    # Terminal
    "float, class:kitty, title:kitty"
    "size 50% 80%, class:kitty, title:kitty"
    "workspace $coding, class:kitty, title:kitty"

    # Code
    "workspace $coding, class:code"

    # Browse
    "workspace $browsing, class:firefox"
  ];
}
