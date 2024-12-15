{
  inputs = {
    nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";
    systems.url = "github:nix-systems/default";
    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { self, nixpkgs, systems, ... }:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      # packages = forEachSystem (system: {
      #   devenv-up = self.devShells.${system}.default.config.procfileScript;
      #   devenv-test = self.devShells.${system}.default.config.test;
      # });
      packages =
        let
          system = "x86_64-linux";
          nixosFunc = nixpkgs.legacyPackages.${system}.nixos;
        in
        {
          ${system} = {
            default = (nixosFunc ./src/features/common.nix).config.system.build.toplevel;
          };
        };

      # devShells = forEachSystem
      #   (system:
      #     let
      #       pkgs = nixpkgs.legacyPackages.${system};
      #     in
      #     {
      #       default = devenv.lib.mkShell {
      #         inherit inputs pkgs;
      #         modules = [
      #           {
      #             # https://devenv.sh/reference/options/
      #             packages = [ pkgs.hello ];

      #             enterShell = ''
      #               hello
      #             '';

      #             processes.hello.exec = "hello";
      #           }
      #         ];
      #       };
      #     });

      nixosModules = {
        features = ./src/features/common.nix;
        default = self.nixosModules.features;
      };

      formatter = forEachSystem (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        pkgs.writeShellApplication {
          name = "format";
          runtimeInputs = with pkgs; [
            nixpkgs-fmt
            deadnix
          ];
          text = ''
            set -o xtrace
            nixpkgs-fmt .
            deadnix --edit "$@"
          '';
        }
      );
      hydraJobs = {
        formatter = self.formatter.x86_64-linux;
        nixos = self.packages.x86_64-linux.default;
      };
    };
}
