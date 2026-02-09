_: {
  perSystem =
    { pkgs, ... }:
    {
      apps.default = {
        type = "app";
        program = toString (
          pkgs.writeShellScript "generate-sponsors" ''
            export PATH="${pkgs.pnpm}/bin:${pkgs.nodejs_24}/bin:$PATH"
            pnpm install --frozen-lockfile
            pnpm run update
          ''
        );
      };
    };
}
