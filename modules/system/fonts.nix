{ pkgs, ... }: {
  config = {
    fonts = {
      packages = with pkgs; [
        nerd-fonts.mplus
        nerd-fonts.fira-code
        jetbrains-mono
        nerd-fonts.jetbrains-mono
      ];
    };
  };
}
