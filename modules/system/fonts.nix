{ config, pkgs, ... }: {
  config = { fonts = { packages = with pkgs; [ nerd-fonts.mplus ]; }; };
}
