_: {
  perSystem =
    { pkgs, ... }:
    {
      treefmt = {
        projectRootFile = "flake.nix";
        programs = {
          nixfmt.enable = true;
          deadnix.enable = true;
          statix.enable = true;
        };
        settings.formatter.oxfmt = {
          command = "${pkgs.oxfmt}/bin/oxfmt";
          options = [ "--no-error-on-unmatched-pattern" ];
          includes = [ "*" ];
        };
      };
    };
}
