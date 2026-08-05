{
  self,
  moduleWithSystem,
  ...
}: {
  flake-file.inputs.noctalia.url = "github:noctalia-dev/noctalia/cachix";

  flake.wrappers.noctalia-v5 = moduleWithSystem ({inputs', ...}: {...}: {
    imports = [self.wrapperModules.noctalia-wrapper];
    package = inputs'.noctalia.packages.default;

    settings =
      fromTOML (builtins.readFile ./config.toml)
      // {
        theme = {
          source = "custom";
          custom_palette = self.theme.name;
        };
      };

    customPalettes = {
      "${self.theme.name}" = with self.theme.palette; {
        dark = {
          mPrimary = base0D;
          mOnPrimary = base00;
          mSecondary = base0E;
          mOnSecondary = base00;
          mTertiary = base0C;
          mOnTertiary = base00;
          mError = base08;
          mOnError = base00;
          mSurface = base00;
          mOnSurface = base05;
          mHover = base0C;
          mOnHover = base00;
          mSurfaceVariant = base01;
          mOnSurfaceVariant = base04;
          mOutline = base03;
          mShadow = base00;
          terminal = {
            background = base00;
            foreground = base07;
            cursor = base05;
            cursorText = base00;
            selectionBg = base02;
            selectionFg = base05;
            normal = {
              black = base00;
              red = base08;
              green = base0B;
              yellow = base0A;
              blue = base0D;
              magenta = base0E;
              cyan = base0C;
              white = base0F;
            };
            bright = {
              black = base00;
              red = base08;
              green = base0B;
              yellow = base0A;
              blue = base0D;
              magenta = base0E;
              cyan = base0C;
              white = base0F;
            };
          };
        };
      };
    };
  });
}
