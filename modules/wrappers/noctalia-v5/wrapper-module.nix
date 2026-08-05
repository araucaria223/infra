{lib, ...}: {
  flake.wrappers.noctalia-wrapper = {
    config,
    wlib,
    pkgs,
    ...
  }: {
    config.meta.description = ''
      Wrapper module for Noctalia shell v5 (the native C++/QML rewrite, `pkgs.noctalia`).

      v5 cleanly separates two layers, unlike v4:

      - Your config: any number of `*.toml` files under
        `$NOCTALIA_CONFIG_HOME/noctalia/` (falls back to `$XDG_CONFIG_HOME`, then
        `~/.config/`). Never written to by the app.
      - GUI-managed overrides: `$NOCTALIA_STATE_HOME/noctalia/settings.toml` (falls back to
        `$XDG_STATE_HOME`, then `~/.local/state/`). Always writable, always outside
        the store, and completely separate from the config layer above.

      Because of that split, this module (unlike the v4 `noctalia-shell` wrapper module
      that ships with nix-wrapper-modules) does not need any "copy config out of the
      store at runtime" trick. `NOCTALIA_CONFIG_HOME` can point straight into the Nix
      store; the GUI still always has a normal writable place to persist its own
      changes, entirely independent of what we generate here.
    '';
    config.meta.platforms = lib.platforms.linux;

    imports = [wlib.modules.default];

    options = {
      settings = lib.mkOption {
        type = wlib.types.structuredValueWith {typeName = "TOML";};
        default = {};
        example = lib.literalExpression ''
          {
            theme = {
              mode = "dark";
              source = "builtin";
              builtin = "Catppuccin";
            };
            wallpaper = {
              enabled = true;
              default.path = "/path/to/wallpaper.png";
            };
          }
        '';
        description = ''
          Noctalia v5 configuration, written as `config.toml` inside the generated
          `NOCTALIA_CONFIG_HOME/noctalia/` directory. Accepts a Nix attribute set
          (converted to TOML), a raw TOML string, or a path to an existing `.toml`
          file.
        '';
      };

      configDirname = lib.mkOption {
        type = lib.types.str;
        default = "noctalia";
        description = ''
          Name of the subdirectory (inside the generated `NOCTALIA_CONFIG_HOME`)
          that Noctalia looks for `*.toml` files in. Only change this if `noctalia`
          itself is told to look somewhere else.
        '';
      };

      configDrvOutput = lib.mkOption {
        type = lib.types.str;
        default = config.outputName;
        description = "Derivation output the generated config directory is placed in.";
      };

      configPlaceholder = lib.mkOption {
        type = lib.types.str;
        default = "${placeholder config.configDrvOutput}/${config.binName}-config";
        readOnly = true;
        description = ''
          Placeholder for the generated `NOCTALIA_CONFIG_HOME` root. Use this inside
          the module; from outside, use `wrapped-noctalia.generatedConfig` (passthru).
        '';
      };

      validateConfig = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = ''
          If true, runs `noctalia config validate <file>` against each generated
          `.toml` file at build time. Errors (bad TOML, invalid values, bad
          `[include]` entries) fail the build; warnings are only printed.
        '';
      };
    };

    config.binName = lib.mkDefault "noctalia";
    config.package = lib.mkDefault pkgs.noctalia;

    config.env.NOCTALIA_CONFIG_HOME = lib.mkIf (config.settings != {}) "${config.configPlaceholder}/";

    config.passthru.generatedConfig = "${config.wrapper.${config.configDrvOutput}}/${config.binName}-config/${config.configDirname}";

    config.constructFiles = {
      settings = lib.mkIf (config.settings != {}) {
        key = "noctaliaConfigToml";
        relPath = lib.mkOverride 0 "${config.binName}-config/${config.configDirname}/config.toml";
        output = lib.mkOverride 0 config.configDrvOutput;
        content = builtins.toJSON config.settings;
        builder = ''${pkgs.remarshal}/bin/json2toml "$1" "$2"'';
      };
    };

    config.buildCommand.validateNoctaliaConfig = lib.mkIf config.validateConfig ''
      ${config.wrapperPaths.placeholder} config validate ${config.configPlaceholder}/${config.configDirname}
    '';
  };
}
