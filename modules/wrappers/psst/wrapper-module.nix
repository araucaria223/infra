{
  lib,
  moduleWithSystem,
  ...
}: {
  flake.wrappers.psst-wrapper = moduleWithSystem ({self', ...}: {
    config,
    wlib,
    ...
  }: {
    config.meta.platforms = lib.platforms.linux;
    imports = [wlib.modules.default];

    options = {
      theme = lib.mkOption {
        default = {};
        type = lib.types.submodule {
          freeformType = wlib.types.attrsRecursive;
        };
      };

      allowAny = lib.mkEnableOption {
        default = false;
      };
    };

    config = {
      package = lib.mkDefault self'.packages.psst-unwrapped;
      wrapperFunction = wlib.makeWrapper.wrapVariants;

      wrapperVariants = let
        themeDir = "${placeholder config.outputName}";
        env = {
          XDG_CONFIG_HOME = lib.mkIf (config.theme != {}) themeDir;
          PSST_ALLOW_ANY_CALLER = lib.mkIf (config.allowAny) "1";
        };
      in {
        keyring = {
          exePath = "bin/psst-keyring-prompter";
          binName = "psst-keyring-prompter";

          inherit env;
        };

        pinentry = {
          exePath = "bin/psst-pinentry";
          binName = "psst-pinentry";

          inherit env;
        };

        polkit = {
          exePath = "bin/psst-polkit-agent";
          binName = "psst-polkit-agent";

          inherit env;
        };
      };

      constructFiles = {
        theme = lib.mkIf (config.theme != {}) {
          key = "psstThemeKdl";
          relPath = lib.mkOverride 0 "psst/theme.kdl";
          content = wlib.toKdl (_: {
            version = 1;
            content = [config.theme];
          });
        };
      };
    };
  });
}
