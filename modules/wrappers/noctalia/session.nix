{lib, ...}: {
  flake.wrappers.noctalia.settings = {pkgs, ...}: let
    systemctl = lib.getExe' pkgs.systemd "systemctl";
  in {
    idle = {
      behavior_order = ["lock" "screen-off" "Lock & Suspend then hibernate"];
      pre_action_fade_seconds = 20;

      behavior = {
        lock = {
          enabled = true;
          action = "lock";
          timeout = 600.0;
        };

        screen-off = {
          enabled = true;
          action = "screen_off";
          timeout = 660.0;
        };

        "Lock & Suspend, Then Hibernate" = {
          enabled = true;
          action = "command";
          command = "${systemctl} suspend-then-hibernate";
          timeout = 900.0;
        };
      };
    };

    shell.session = {
      grid = true;
      grid_columns = 1;

      actions = [
        {
          action = "lock";
          shortcut = "l";
          countdown_seconds = 0.0;
          variant = "ghost";
          enabled = true;
        }

        {
          label = "Hibernate";
          action = "command";
          command = "${systemctl} hibernate";
          shortcut = "h";
          countdown_seconds = 10.0;
          variant = "ghost";
          glyph = "player-pause";
          enabled = true;
        }

        {
          action = "reboot";
          shortcut = "r";
          countdown_seconds = 10.0;
          variant = "destructive";
          enabled = true;
        }

        {
          action = "shutdown";
          shortcut = "s";
          countdown_seconds = 10.0;
          variant = "destructive";
          enabled = true;
        }
      ];
    };
  };
}
