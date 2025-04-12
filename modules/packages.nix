{ pkgs }:
with pkgs; {
  common = with pkgs; {
    editors = [
      # Editor software
      vscode
      emacs
    ];
    vc = [
      # Version control
      git
    ];
    access = [ gnupg ];
  };
}
