_: {
  perSystem =
    { pkgs, ... }:
    {
      apps.default = {
        type = "app";
        program = toString (
          pkgs.writeShellScript "generate-sponsors" ''
            ${pkgs.bun}/bin/bun ci
            ${pkgs.bun}/bin/bun run update
          ''
        );
      };
    };
}
