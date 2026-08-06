{lib, ...}: {
  flake-file.inputs.nixos-hardware = {
    url = "github:nixos/nixos-hardware";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules = {
    options.disko = lib.mkOption {
      type = lib.types.attrsOf lib.types.attrsOf lib.types.unspecified;
      default = {};
    };
  };
}
