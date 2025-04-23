{ pkgs, config, ... }: {
  home = {
    file = {
      emacs-config = {
        target = ".config/emacs/init.el";
        source = config.lib.file.mkOutOfStoreSymlink ./config.el;
      };
    };
    packages = with pkgs; [
      nixd # Nix Language Server
      gopls # Go Language Server
      bash-language-server # Bash Language Server
      yaml-language-server # Yaml Language Server
      dockerfile-language-server-nodejs # Dockerfile Language Server
      terraform-lsp # Terraform Language Server
      vscode-langservers-extracted # CSS, HTML, Eslint, JSON
      marksman # Markdown
      csharp-ls # C# Language Server
      fsautocomplete # F# Language Server

      mpv # Media player
    ];
  };
  programs.emacs = {
    package = (pkgs.emacsWithPackagesFromUsePackage {
      package = pkgs.emacs-git-pgtk;
      config = ./config.el;
    });
    enable = true;
  };
  services = {
    emacs = {
      startWithUserSession = "graphical";
      enable = true;
    };
  };
}
