_: {
  perSystem =
    { config, pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          bun
          typescript-go
          oxlint
          oxfmt
          typos-lsp
          gitleaks
          nixd
        ];
        shellHook = ''
          ${config.pre-commit.installationScript}
          bun ci
        '';
      };
    };
}
