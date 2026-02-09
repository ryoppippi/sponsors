_: {
  perSystem =
    { pkgs, ... }:
    {
      apps.default = {
        type = "app";
        program = toString (
          pkgs.writeShellScript "generate-sponsors" ''
            export PATH="${pkgs.bun}/bin:$PATH"
            bun ci
            bun run update
          ''
        );
      };
    };
}
