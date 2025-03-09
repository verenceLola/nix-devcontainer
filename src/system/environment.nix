{ config, pkgs, ... }:
with pkgs; {
  config = { environment.systemPackages = [ emacs kitty ]; };
}
