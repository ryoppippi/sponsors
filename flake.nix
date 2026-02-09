{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    git-hooks.url = "github:cachix/git-hooks.nix";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    inputs@{
      flake-parts,
      git-hooks,
      treefmt-nix,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      perSystem =
        { pkgs, system, ... }:
        let
          treefmtEval = treefmt-nix.lib.evalModule pkgs {
            projectRootFile = "flake.nix";
            programs = {
              nixfmt.enable = true;
              deadnix.enable = true;
              statix.enable = true;
            };
            settings.formatter.oxfmt = {
              command = "${pkgs.oxfmt}/bin/oxfmt";
              includes = [
                "*.md"
                "*.yml"
                "*.yaml"
                "*.json"
                "*.jsonc"
                "*.toml"
                "*.ts"
              ];
              excludes = [ ];
            };
          };

          pre-commit-check = git-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              gitleaks = {
                enable = true;
                name = "gitleaks";
                entry = "${pkgs.gitleaks}/bin/gitleaks protect --staged --config .gitleaks.toml";
                language = "system";
                pass_filenames = false;
              };
              treefmt = {
                enable = true;
                package = treefmtEval.config.build.wrapper;
              };
            };
          };
        in
        {
          formatter = treefmtEval.config.build.wrapper;

          checks = {
            inherit pre-commit-check;

            formatting = treefmtEval.config.build.check ./.;

            typos =
              pkgs.runCommand "check-typos"
                {
                  nativeBuildInputs = [ pkgs.typos ];
                  src = ./.;
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
                  src = ./.;
                }
                ''
                  cd $src
                  gitleaks detect --source . --config .gitleaks.toml --no-git
                  touch $out
                '';
          };

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
              ${pre-commit-check.shellHook}
              bun ci
            '';
          };

          apps.default = {
            type = "app";
            program = toString (
              pkgs.writeShellScript "generate-sponsors" ''
                export PATH="${
                  pkgs.lib.makeBinPath (
                    with pkgs;
                    [
                      bun
                      typescript-go
                    ]
                  )
                }:$PATH"
                bun ci
                bun run update
              ''
            );
          };
        };
    };
}
