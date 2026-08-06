{self, ...}: {
  flake.wrappers.noctalia-v5 = {...}: {
    imports = [self.wrapperModules.noctalia-wrapper];

    settings =
      fromTOML (builtins.readFile ./config.toml)
      // {
        theme = {
          source = "custom";
          custom_palette = self.theme.name;
        };

        backdrop = {
          enabled = true;
          blur_intensity = 0.5;
          tint_intensity = 0.3;
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
          terminal = {};
        };
      };
    };
  };
}
