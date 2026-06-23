{
  self,
  moduleWithSystem,
  ...
}: {
  flake.modules.generic.library.library.allowedUnfreePackages = ["stremio-linux-shell"];
  flake.modules.nixos.desktop = moduleWithSystem ({self', ...}: {
    config,
    pkgs,
    ...
  }: {
    imports = [
      self.modules.nixos.wireless
      self.modules.nixos.bluetooth
    ];

    programs.niri = {
      enable = true;
      package = self'.packages.desktop;
    };

    programs.firefox.enable = true;

    services = {
      upower.enable = true;
      power-profiles-daemon.enable = true;
      libinput.enable = true;
    };

    users.users.araucaria.packages = with pkgs; [
      stremio-linux-shell
      qbittorrent
      keepassxc
    ];

    # UPDATEME
    preservation.preserveAt."/persistent" = {
      directories = [
        {
          directory = "/var/lib/fprint";
          mode = "700";
        }
      ];

      users.${config.users.users.araucaria.name}.directories = [];
    };

    environment.sessionVariables = {
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_CACHE_HOME = "$HOME/.cache";
    };
  });
}
