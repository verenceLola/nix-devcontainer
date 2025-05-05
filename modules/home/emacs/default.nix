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
      omnisharp-roslyn # .NET
      fsautocomplete # F# Language Server
      lemminx # XML
      mpv # Media player

      tailwindcss-language-server # Tailwindcss Language Server
      typescript-language-server # JS/TS Language Server
      typescript
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
