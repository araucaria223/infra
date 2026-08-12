{self, ...}: {
  flake.modules.nixos.limine = {pkgs, ...}: {
    boot.loader.limine = {
      enable = true;
      secureBoot.enable = true;

      style = with self.theme.paletteNoHash; {
        graphicalTerminal = {
          palette = "${base05};${base08};${base0B};${base0A};${base0D};${base0E};${base0C};${base00}";
          brightPalette = "${base00};${base08};${base0B};${base0A};${base0D};${base0E};${base0C};${base05}";
          background = base00;
          foreground = base05;
          brightBackground = base05;
          brightForeground = base0A;
        };
        backdrop = base00;
      };
    };

    # Needed to set up secure boot
    environment.systemPackages = [pkgs.sbctl];
  };

  flake.modules.nixos.preservation = {
    preservation.preserveAt."/persistent".directories = [
      "/var/lib/sbctl"
    ];
  };
}
