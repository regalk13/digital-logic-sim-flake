{
  description = "Digital-Logic-Sim packaged for Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [ ./formatters.nix ];
      perSystem =
        { pkgs, ... }:
        let
          package = pkgs.callPackage ./package.nix { };
        in
        {
          packages.default = package;

          apps.default = {
            type = "app";
            program = "${package}/bin/digital-logic-sim";
          };

          devShells.default = pkgs.mkShell {
            packages = [ package ];
          };
        };
    };
}
