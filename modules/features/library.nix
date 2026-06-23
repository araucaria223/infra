{...}: {
  flake.modules.generic.library = {lib, ...}: {
    options.library = lib.mkOption {
      type = lib.types.attrsOf lib.types.unspecified;
      default = {};
    };

    config.library = {};
  };
}
