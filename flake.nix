{
  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs?ref=nixos-unstable"; };
    systems.url = "github:nix-systems/default";
    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs = {
        hyprlang.follows = "hyprland/hyprlang";
        nixpkgs.follows = "nixpkgs";
      };
    };
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        hyprlang.follows = "hyprland/hyprlang";
      };
    };
    emacs-overlay = { url = "github:nix-community/emacs-overlay"; };
  };

  outputs = { self, nixpkgs, systems, ... }@args:
    let forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in {
      packages = let system = "x86_64-linux";

      in {
        # Add .dotfiles as one of the packages
        ${system} = {
          # docker = nixos-generators.nixosGenerate {
          #   inherit system;
          #   modules = [ ./src/features/common.nix ];
          #   format = "docker";
          # };
        };
      };

      nixosConfigurations = import ./hosts args;

      devShell = forEachSystem (system:
        let pkgs = import nixpkgs { inherit system; };
        in pkgs.mkShell {
          EDITOR = "${pkgs.emacs-pgtk}/bin/emacs";
          buildInputs = with pkgs; [ nixos-rebuild ssh-to-age emacs sops ];
          shellHook = ''
            KEYS_DIR=$HOME/.config/sops/age
            mkdir -p $KEYS_DIR
            ssh-add -q # import existing keys
            ssh-to-age -private-key -i $HOME/.ssh/id_ed25519 -o $KEYS_DIR/keys.txt
          '';
        });

      formatter = forEachSystem (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in pkgs.writeShellApplication {
          name = "format";
          runtimeInputs = with pkgs; [ nixfmt-classic deadnix ];
          text = ''
            set -o xtrace
            shopt -s globstar
            nixfmt ./**/*.nix
            deadnix --edit "$@"
          '';
        });
      hydraJobs = let system = "x86_64-linux";
      in nixpkgs.lib.attrsets.mergeAttrsList [
        { formatter = self.formatter.${system}; }
        (import ./utils/hydraJobs.nix { inherit self nixpkgs; })
      ];
    };
}
