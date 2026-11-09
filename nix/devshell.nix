_: {
  perSystem =
    { config, pkgs, ... }:
    {
      devShells.default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          nodejs_24
          pnpm
          typescript
          oxlint
          oxfmt
          typos-lsp
          gitleaks
          nixd
        ];
        shellHook = ''
          ${config.pre-commit.installationScript}
          pnpm install --frozen-lockfile
        '';
      };
    };
}
