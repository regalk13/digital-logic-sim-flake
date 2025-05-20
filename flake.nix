{
  description = "Digital-Logic-Sim packaged for Nix";

  inputs = {
    nixpkgs.url       = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url   = "github:hercules-ci/flake-parts";
    treefmt-nix.url   = "github:numtide/treefmt-nix";
  };

  outputs = inputs@{ flake-parts, nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [ ./formatters.nix ];

      perSystem = { pkgs, ... }: let
        mkDls = { version, url, hash }: pkgs.callPackage ./package.nix {
          inherit version url hash;
        };

        dls        = mkDls {
          version = "2.1.6";
          url     = "https://github.com/regalk13/digital-logic-sim-flake/releases/download/2.1.6/Digital-Logic-Sim-Linux.zip";
          hash    = "sha256-vYr3JUGJQVSYY3Hoa6EqqagJ7tZB56A74fEjVStnB2Q=";
        };

        dls16bit   = mkDls {
          version = "2.1.6-16bit";
          url     = "https://github.com/regalk13/digital-logic-sim-flake/releases/download/2.1.6-test/Digital-Logic-Sim-Linux.zip";
          hash    = "sha256-ouW3YM9AZh5i+M38OzFXHrPNJMUQFHT4wWJuseSucJg=";
        };
      in {
        packages = {
          default    = dls;
          fork16bit  = dls16bit;
        };

        apps = {
          default   = {
            type    = "app";
            program = "${dls}/bin/digital-logic-sim";
          };
          fork16bit = {
            type    = "app";
            program = "${dls16bit}/bin/digital-logic-sim";
          };
        };

        devShells = {
          default   = pkgs.mkShell { packages = [ dls ]; };
          fork16bit = pkgs.mkShell { packages = [ dls16bit ]; };
        };
      };
    };
}
