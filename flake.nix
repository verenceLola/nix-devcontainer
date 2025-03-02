{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/default";
    devenv = {
      url = "github:cachix/devenv";
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
  };

  # nixConfig = {
  #   extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
  #   extra-substituters = "https://devenv.cachix.org";
  # };

  outputs = { self, nixpkgs, nixos-generators, agenix, disko, systems, ... }:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
      nixosSystem = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          self.nixosModules.default
          agenix.nixosModules.default
          ./src/hardware
          disko.nixosModules.disko
        ];
      };
      iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          targetSystem = self.nixosConfigurations.nixos;
        };
        modules = [
          ./src/installer/iso.nix
        ];
      };
    in
    {
      # packages = forEachSystem (system: {
      #   devenv-up = self.devShells.${system}.default.config.procfileScript;
      #   devenv-test = self.devShells.${system}.default.config.test;
      # });
      # cool = {
      #   nixosSystem = nixpkgs.lib.nixosSystem {
      #     system = "x86_64-linux";
      #     modules = [
      #       self.nixosModules.default
      #     ];
      #   };
      # };
      packages =
        let
          system = "x86_64-linux";
          version = "${builtins.substring 0 8 (self.lastModifiedDate or "19700101")}.${self.shortRev or "DIRTY"}";
          isoDrv = self.nixosConfigurations.iso.config.system.build.isoImage.overrideAttrs {
            name = "nixos-${version}.iso";
          };
        in
        {
          ${system} = {
            default = self.packages.${system}.iso;
            iso = isoDrv;
            docker = nixos-generators.nixosGenerate {
              inherit system;
              modules = [
                self.nixosModules.default
                agenix.nixosModules.default
              ];
              format = "docker";
            };
          };
        };

      nixosConfigurations = {
        iso = iso;
        nixos = nixosSystem;
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
      hydraJobs =
        let
          system = "x86_64-linux";
        in
        {
          formatter = self.formatter.${system};
          iso = self.packages.${system}.default;
          nixos = self.nixosConfigurations.nixos.config.system.build.toplevel;
          docker = self.packages.${system}.docker;
        };
    };
}
