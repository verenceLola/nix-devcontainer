{ config, pkgs, ... }: {
  config = { fonts = { packages = with pkgs; [ font-awesome ]; }; };
}
