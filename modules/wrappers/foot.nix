{
  self,
  lib,
  ...
}: {
  flake.wrappers.foot = {
    wlib,
    pkgs,
    config,
    ...
  }: {
    imports = [wlib.wrapperModules.foot];

    options = {
      shell = lib.mkOption {
        type = lib.types.str;
	default = "fish";
      };

      theme = lib.mkOption {
        default = self.theme;
      };
    };

    config = {
      addFlag = lib.mkAfter (lib.optionals (config.shell != "") [config.shell]);
      env."FONTCONFIG_FILE" = let
        customFontconfig = pkgs.makeFontsConf {
          fontDirectories = ["${pkgs.nerd-fonts.jetbrains-mono}"];
        };
      in "${customFontconfig}";

      settings = {
        main = {
          initial-color-theme = "dark";
          font = "JetBrainsMono Nerd Font:size=11";
          dpi-aware = "no";
          pad = "15x15 center-when-maximized-and-fullscreen";
	  shell = config.shell;
        };

	scrollback = {
	  lines = 10000;
	};

        colors-dark = with config.theme.paletteNoHash; {
          foreground = base05;
          background = base00;
          regular0 = base00;
          regular1 = base08;
          regular2 = base0B;
          regular3 = base0A;
          regular4 = base0D;
          regular5 = base0E;
          regular6 = base0C;
          regular7 = base05;
          bright0 = base03;
          bright1 = base08;
          bright2 = base0B;
          bright3 = base0A;
          bright4 = base0D;
          bright5 = base0E;
          bright6 = base0C;
          bright7 = base07;
          "16" = base09;
          "17" = base0F;
          "18" = base01;
          "19" = base02;
          "20" = base04;
          "21" = base06;
        };
      };
    };
  };
}
