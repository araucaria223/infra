{
  self,
  moduleWithSystem,
  ...
}: {
  flake.modules.nixos.desktop = moduleWithSystem ({self', ...}: {pkgs, ...}: {
    imports = [
      self.modules.nixos.xdg
      self.modules.nixos.wireless
      self.modules.nixos.bluetooth
    ];

    console.colors = with self.theme.paletteNoHash; [
      base00
      base08
      base0B
      base0A
      base0D
      base0E
      base0C
      base05
      base03
      base08
      base0B
      base0A
      base0D
      base0E
      base0C
      base07
    ];

   # qt = {
   #   enable = true;
   #   platformTheme = "gtk2";
   #   style = "gtk2";
   # };

    security.pam.services = {
      greetd.enableGnomeKeyring = true;
      login = {
        enableGnomeKeyring = true;
        fprintAuth = false;
      };
    };

    programs.niri = {
      enable = true;
      package = self'.packages.desktop;
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

    environment.systemPackages = [
      pkgs.qt6Packages.qtwayland
    ];

    users.users.araucaria.packages = with pkgs; [
      self'.packages.terminal
      qbittorrent
      keepassxc
    ];

    environment.sessionVariables = {
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_CACHE_HOME = "$HOME/.cache";

      XDG_DATA_DIRS = ["${pkgs.phinger-cursors}/share"];
      XCURSOR_THEME = "${pkgs.phinger-cursors}/share/icons/phinger-cursors-dark";
      XCURSOR_SIZE = "20";
      XCURSOR_PATH = ["${pkgs.phinger-cursors}/share/icons"];

      NIXOS_OZONE_WL = "1";
    };
  });

  flake.modules.nixos.preservation = {config, ...}: {
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
  };
}
