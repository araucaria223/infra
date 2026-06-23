{lib, ...}: {
  flake-file.inputs.nixos-hardware.url = "github:nixos/nixos-hardware";

  flake.modules = {
    options.disko = lib.mkOption {
      type = lib.types.attrsOf lib.types.attrsOf lib.types.unspecified;
      default = {};
    };
  };
}
