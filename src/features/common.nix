{ config, agenix, lib, ... }: with lib;
let
  availablePrograms = import ../programs.nix { };
  # requiredPkgs = import ../packages.nix { inherit pkgs; };
in
{
  imports = [
    ../system
  ];

  options = {
    features = {
      agenix = {
        enable = mkEneableOption "Enable Agenix packages installation" {
          default = true;
        };
      };
      vc = {
        enable = mkEneableOption "Install version control softwares" {
          default = true;
        };
      };
      editors = {
        enable = mkEneableOption "Install common editors" {
          default = true;
        };
      };
    };
  };

  config = {
    # packages = trivial.concat (foldr concat (getAttr "common" requiredPkgs)) [ ]; # vcPkgs agenixPkgs;
    programs = lib.getAttr "common" availablePrograms;
  };
}
