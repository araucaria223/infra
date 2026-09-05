{inputs, ...}: let
  stripHash = str:
    if builtins.substring 0 1 str == "#"
    then builtins.substring 1 (builtins.stringLength str - 1) str
    else str;

  mkTheme = slug: rec {
    inherit (inputs.basix.schemeData.base16."${slug}") palette name;
    paletteNoHash = builtins.mapAttrs (_: v: stripHash v) palette;
  };
in {
  flake-file.inputs.basix = {
    url = "github:notashelf/basix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.theme = mkTheme "everforest";
  flake.library.library = {
    inherit mkTheme;
  };
}
