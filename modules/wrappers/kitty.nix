{
  self,
  lib,
  ...
}: {
  flake.wrappers.kitty = {
    wlib,
    config,
    ...
  }: {
    imports = [wlib.wrapperModules.kitty];

    options = {
      shell = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
      theme = lib.mkOption {
        default = self.theme;
      };
    };

    config = with config.theme; {
      addFlag = lib.mkAfter (lib.optionals (config.shell != "") [config.shell]);
      settings = {
        scrollback_lines = 10000;
        enable_audio_bell = false;
        disable_ligatures = "never";

        window_padding_width = 10;
        confirm_os_window_close = 0;

        background = palette.base00;
        foreground = palette.base07;

        cursor = palette.base07;

        selection_foreground = palette.base02;
        selection_background = palette.base01;

        active_tab_foreground = palette.base0B;
        active_tab_background = palette.base03;
        inactive_tab_background = palette.base01;

        color0 = palette.base00;
        color8 = palette.base02;
        color1 = palette.base08;
        color9 = palette.base08;
        color2 = palette.base0B;
        color10 = palette.base0B;
        color3 = palette.base0A;
        color11 = palette.base0A;
        color4 = palette.base0D;
        color12 = palette.base0D;
        color5 = palette.base0E;
        color13 = palette.base0E;
        color6 = palette.base0C;
        color14 = palette.base0C;
        color7 = palette.base03;
        color15 = palette.base03;
      };
    };
  };
}
