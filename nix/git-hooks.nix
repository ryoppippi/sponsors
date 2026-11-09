_: {
  perSystem =
    { config, ... }:
    {
      pre-commit.settings.hooks = {
        gitleaks.enable = true;
        treefmt = {
          enable = true;
          package = config.treefmt.build.wrapper;
        };
      };
    };
}
