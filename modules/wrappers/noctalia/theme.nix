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
        custom_palette = config.theme.name;
      };

      customPalettes."${config.theme.name}".dark = with config.theme.palette; {
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
}
