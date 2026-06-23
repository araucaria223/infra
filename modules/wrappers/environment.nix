{
  lib,
  self,
  moduleWithSystem,
  ...
}: {
  flake.wrappers = {
    desktop = moduleWithSystem ({self', ...}: {pkgs, ...}: {
      imports = [self.wrapperModules.niri];
      terminal = lib.getExe self'.packages.terminal;

      env = {
        EDITOR = lib.getExe self'.packages.neovim;
      };

      runtimePkgs = [
        pkgs.mpv
      ];
    });

    terminal = moduleWithSystem ({self', ...}: {...}: {
      imports = [self.wrapperModules.kitty];

      shell = lib.getExe self'.packages.environment;
    });

    environment = moduleWithSystem ({self', ...}: {...}: {
      imports = [self.wrapperModules.fish];

      runtimePkgs = [
        self'.packages.git
        self'.packages.nh
      ];

      env = {
        # CHANGE
        EDITOR = lib.getExe self'.packages.neovim;
      };
    });
  };
}
