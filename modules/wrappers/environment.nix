{
  lib,
  self,
  moduleWithSystem,
  ...
}: {
  flake.wrappers = {
    desktop = moduleWithSystem ({self', ...}: {pkgs, ...}: {
      imports = [self.wrapperModules.niri];
      terminal = lib.getExe' self'.packages.terminal "footclient";

      env = {
        EDITOR = lib.getExe pkgs.neovim;
      };

      runtimePkgs = [
        pkgs.mpv
      ];
    });

    terminal = moduleWithSystem ({self', ...}: {...}: {
      imports = [self.wrapperModules.foot];

      shell = self'.packages.environment;
    });

    environment = moduleWithSystem ({self', ...}: {pkgs, ...}: {
      imports = [self.wrapperModules.fish];

      runtimePkgs = [
        self'.packages.git
        self'.packages.nh
      ];

      env = {
        # CHANGE
        EDITOR = lib.getExe pkgs.neovim;
      };
    });
  };
}
