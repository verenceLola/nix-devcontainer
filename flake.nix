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

  outputs = { self, nixpkgs, nixos-generators, agenix, disko, systems, ... }:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);

      nixosSystem = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          self.nixosModules.default
          agenix.nixosModules.default
          ./src
          disko.nixosModules.disko
        ];
        specialArgs = {
          suggestedHostName = "nixos-${builtins.substring 0 8 self.lastModifiedDate}";
        };
      };
      iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          targetSystem = self.nixosConfigurations.nixos;
        };
        modules = [
          ./src/installer
        ];
      };
    in
    {
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

      devShell = forEachSystem
        (system:
          let
            pkgs = import nixpkgs {
              inherit system;
            };
          in
          pkgs.mkShell {
            buildInputs = with pkgs; [
              nixos-rebuild
            ];
          });

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
