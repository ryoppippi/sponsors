_: {
  perSystem =
    { config, pkgs, ... }:
    {
      pre-commit.settings.hooks = {
        gitleaks = {
          enable = true;
          name = "gitleaks";
          entry = "${pkgs.gitleaks}/bin/gitleaks protect --staged --config .gitleaks.toml";
          language = "system";
          pass_filenames = false;
        };
        treefmt = {
          enable = true;
          package = config.treefmt.build.wrapper;
        };
      };
    };
}
