{
  self,
  moduleWithSystem,
  ...
}: {
  flake.modules.generic.library.library.allowedUnfreePackages = ["stremio-linux-shell"];

  flake.modules.nixos.desktop = moduleWithSystem ({self', ...}: {
    config,
    pkgs,
    lib,
    ...
  }: {
    imports = [
      self.modules.nixos.wireless
      self.modules.nixos.bluetooth
    ];

    security.pam.services = {
      greetd.enableGnomeKeyring = true;
      login.enableGnomeKeyring = true;
    };

    programs.niri = {
      enable = true;
      package = self'.packages.desktop;
    };

    services.greetd = lib.mkIf (config.specialisation != {}){
      enable = true;
      useTextGreeter = true;
      settings.default_session = {
        user = "greeter";
        command = lib.getExe' pkgs.tuigreet "tuigreet";
      };
    };

    security.pam.services.login.fprintAuth = false;

    services.spotifyd = {
      enable = true;
      settings = {
        backend = "pipe";
        bitrate = 320;
      };
    };

    programs.firefox = {
      enable = true;
      package = self'.packages.firefox;
    };

    services = {
      upower.enable = true;
      power-profiles-daemon.enable = true;
      libinput.enable = true;
    };

    users.users.araucaria.packages = with pkgs; [
      self'.packages.terminal
      vscodium
      vesktop
      spotatui
      stremio-linux-shell
      qbittorrent
      keepassxc
      element-desktop
    ];

    # UPDATEME
    preservation.preserveAt."/persistent" = {
      directories = [
        {
          directory = "/var/lib/fprint";
          mode = "700";
        }
      ];

      users.${config.users.users.araucaria.name} = {
        directories = [
          ".stremio-server"
          ".local/share/stremio"

          ".local/state/noctalia/notification_history_assets"
        ];

        files = [
          {
            file = ".local/state/noctalia/notification_history.json";
            configureParent = true;
          }
          ".local/state/noctalia/usage_counts.json"
          ".local/state/noctalia/recently_used.json"
        ];
      };
    };

    environment.sessionVariables = {
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_CACHE_HOME = "$HOME/.cache";

      XDG_DATA_DIRS = ["${pkgs.phinger-cursors}/share"];
      XCURSOR_THEME = "${pkgs.phinger-cursors}/share/icons/phinger-cursors-dark";
      XCURSOR_SIZE = "20";
      XCURSOR_PATH = ["${pkgs.phinger-cursors}/share/icons"];
    };
  });
}
