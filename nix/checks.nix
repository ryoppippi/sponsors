_: {
  perSystem =
    { pkgs, ... }:
    {
      checks = {
        typos =
          pkgs.runCommand "check-typos"
            {
              nativeBuildInputs = [ pkgs.typos ];
              src = ./..;
            }
            ''
              cd $src
              typos
              touch $out
            '';

        gitleaks =
          pkgs.runCommand "check-gitleaks"
            {
              nativeBuildInputs = [ pkgs.gitleaks ];
              src = ./..;
            }
            ''
              cd $src
              gitleaks detect --source . --config .gitleaks.toml --no-git
              touch $out
            '';
      };
    };
}
