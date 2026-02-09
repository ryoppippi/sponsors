_: {
  perSystem =
    { pkgs, ... }:
    let
      fonts = [
        pkgs.roboto
        pkgs.open-sans
        pkgs.ubuntu-sans
        pkgs.cantarell-fonts
        pkgs.liberation_ttf
        pkgs.dejavu_fonts
        pkgs.noto-fonts-color-emoji # spellchecker:disable-line
      ];
      fontsConf = pkgs.makeFontsConf { fontDirectories = fonts; };
    in
    {
      apps.default = {
        type = "app";
        program = toString (
          pkgs.writeShellScript "generate-sponsors" ''
            export PATH="${pkgs.pnpm}/bin:${pkgs.nodejs_24}/bin:$PATH"
            export FONTCONFIG_FILE="${fontsConf}"
            pnpm install --frozen-lockfile
            pnpm run update
          ''
        );
      };
    };
}
