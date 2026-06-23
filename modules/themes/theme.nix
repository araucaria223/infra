{lib, ...}: let
  stripHash = str:
    if builtins.substring 0 1 str == "#"
    then builtins.substring 1 (builtins.stringLength str - 1) str
    else str;

  mkTheme = name: let
    rawTheme = lib.importJSON ./schemes/${name}.json;
  in {
    inherit (rawTheme) palette name;
    paletteNoHash = builtins.mapAttrs (_: v: stripHash v) rawTheme.palette;
  };
in {
  flake.theme = mkTheme "everforest";

  flake.library = {
    library = {
      inherit mkTheme;
    };
  };
}
