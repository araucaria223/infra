{
  self,
  lib,
  moduleWithSystem,
  ...
}: let
  mkWhichKey = {
    pkgs,
    theme,
    menu,
  }: (self.wrappers.wlr-which-key.wrap {
    inherit pkgs theme;
    settings = {
      inherit menu;
    };
  });
in {
  flake.wrappers.wlr-which-key = {
    wlib,
    config,
    ...
  }: {
    imports = [wlib.wrapperModules.wlr-which-key];

    options.theme = lib.mkOption {
      default = self.theme;
    };

    config.settings = with config.theme; {
      background = palette.base00;
      color = palette.base06;
      border = palette.base0F;

      separator = " ➜ ";
      border_width = 2;
      corner_r = 15;
      padding = 15;
      rows_per_column = 5;
      column_padding = 25;

      anchor = "bottom-right";
      margin_right = 0;
      margin_bottom = 5;
      margin_left = 5;
      margin_top = 0;
    };
  };

  flake.modules.generic.library = moduleWithSystem ({pkgs, ...}: {...}: {
    library.mkWhichKeyExe = {
      menu,
      theme ? self.theme,
    }:
      lib.getExe
      (mkWhichKey {inherit pkgs menu theme;});
  });
}
