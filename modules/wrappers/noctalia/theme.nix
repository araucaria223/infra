{
  self,
  lib,
  ...
}: {
  flake.wrappers.noctalia = {config, ...}: {
    options.theme = lib.mkOption {
      default = self.theme;
    };

    config = {
      settings.theme = {
        source = "custom";
        custom_palette = "custom";
      };

      colors = with config.theme.palette; {
        version = 2;
        dark = {
          # Core roles
          primary = base0D;
          on_primary = base00;
          secondary = base0E;
          on_secondary = base00;
          tertiary = base0C;
          on_tertiary = base00;
          error = base08;
          on_error = base00;

          # Surface / text
          surface = base00;
          on_surface = base05;
          on_surface_variant = base04;
          surface_container = base01;
          on_surface_container = base04; # if you need the on_* variant
          outline_variant = base03;       # renamed from outline

          # Shadow / interaction
          shadow = base00;
          hover = base0C;
          on_hover = base00;

          # Terminal (normal + bright)
          terminal = {
            background = base00;
            foreground = base05;
            cursor = base05;
            cursor_text = base00;
            selection_bg = base02;
            selection_fg = base05;

            normal = [
              base00  # black
              base08  # red
              base0B  # green
              base0A  # yellow
              base0D  # blue
              base0E  # magenta
              base0C  # cyan
              base05  # white
            ];

            bright = [
              base03  # bright black
              base09  # bright red
              base01  # bright green
              base02  # bright yellow
              base04  # bright blue
              base06  # bright magenta
              base0F  # bright cyan
              base07  # bright white
            ];
          };
        };
      };
    };
  };
}
