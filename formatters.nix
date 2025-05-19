{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem =
    { pkgs, ... }:
    {
      treefmt = {
        projectRootFile = ".git/config";

        programs = {
          nixfmt.enable = true;
          nixfmt.package = pkgs.nixfmt-rfc-style;
          deadnix.enable = true;
        };
        settings.global.excludes = [
          "LICENSE"
        ];
      };
    };
}
