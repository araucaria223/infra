{
  self,
  lib,
  ...
}: {
  flake.wrappers.noctalia = {
    pkgs,
    config,
    ...
  }: {
    imports = [self.wrapperModules.noctalia-wrapper];

    options.theme = lib.mkOption {
      default = self.theme;
    };

    config = {
      settings = let
        systemctl = lib.getExe' pkgs.systemd "systemctl";
      in {
        theme = {
          source = "custom";
          custom_palette = config.theme.name;
        };

        wallpaper = {
          directory = "~/Pictures/Wallpapers";
          fill_color = config.theme.palette.base00;
          automation = {
            enabled = true;
            interval_seconds = 1800;
            order = "random";
          };
        };

        audio.enable_sounds = true;

        backdrop = {
          enabled = true;
          blur_intensity = 0.5;
          tint_intensity = 0.3;
        };

        brightness.minimum_brightness = 0.01;
        control_center = {
          sidebar_section = "none";
          width = 600;
          calendar.show_events_card = false;
        };

        dock = {
          enabled = false;
          #  active_scale = 0.9;
          #  icon_size = 35;
          #  launcher_position = "start";
          #  main_axis_padding = 10;
          #  pinned = ["Firefox" "kitty" "stremio" "KeePassXC"];
          #  radius = 10;
          #  reserve_space = false;
          #  show_dots = true;
          #  show_instance_count = false;
          #  smart_auto_hide = true;
        };

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

        location.auto_locate = false;
        nightlight.enabled = true;
        notification.layer = "overlay";

        osd = {
          background_opacity = 0.97;
          offset_x = 10;
          orientation = "vertical";
          position = "center_right";
          position_vertical = "center_right";
        };

        shell = {
          launch_apps_as_systemd_services = false;
          niri_overview_type_to_launch_enabled = true;
          setup_wizard_enabled = false;

          launcher.compact = true;
          screenshot.confirm_region = true;
          panel = {
            clipboard_placement = "attached";
            open_near_click_control_center = true;
          };

          session = {
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

        bar = {
          top = {
            enabled = false;
            capsule = true;
            capsule_group = [
              {
                id = "networking";
                members = ["bluetooth" "network"];
                opacity = 1.0;
                padding = 6.0;
                fill = "surface_variant";
                enabled = true;
              }

              {
                id = "system-info";
                members = ["battery" "brightness" "volume"];
                opacity = 1.0;
                padding = 6.0;
                fill = "surface_variant";
                enabled = true;
              }

              {
                id = "controls";
                members = ["control-center" "session"];
                opacity = 1.0;
                padding = 6.0;
                fill = "surface_variant";
                enabled = true;
              }
            ];

            start = ["clock" "media" "tray"];
            center = ["workspaces"];
            end = [
              "group:networking"
              "group:system-info"
              "notifications"
              "group:controls"
            ];

            margin_ends = 0;
            radius_top_left = 0;
            radius_top_right = 0;
          };
          side = {
            position = "left";
            margin_ends = 0;
            radius_bottom_left = 0;
            radius_top_left = 0;
            capsule_group = [
              {
                id = "networking";
                members = ["bluetooth" "network"];
                opacity = 1.0;
                padding = 6.0;
                fill = "surface_variant";
                enabled = true;
              }

              {
                id = "system-info";
                members = ["volume" "brightness" "battery"];
                opacity = 1.0;
                padding = 6.0;
                fill = "surface_variant";
                enabled = true;
              }
            ];

            start = [
              "session"
              "control-center"
              "notifications"
              "group:networking"
              "media"
            ];
            center = ["workspaces"];
            end = ["tray" "group:system-info" "clock"];
          };
        };

        widget = {
          media.hide_when_no_media = true;
          network = {
            capsule = true;
            show_label = false;
            vpn_status = "both";
          };

          battery.show_label = false;
          brightness.show_label = false;
          volume.show_label = false;

          control-center.glyph = "adjustments";

          session = {
            capsule = true;
            color = "secondary";
          };

          workspaces = {
            anchor = true;
            labels_only_when_occupied = true;
            style = "focus_hint";
          };
        };
      };

      customPalettes = {
        "${config.theme.name}" = with config.theme.palette; {
          dark = {
            mPrimary = base0D;
            mOnPrimary = base00;
            mSecondary = base0E;
            mOnSecondary = base00;
            mTertiary = base0C;
            mOnTertiary = base00;
            mError = base08;
            mOnError = base00;
            mSurface = base00;
            mOnSurface = base05;
            mHover = base0C;
            mOnHover = base00;
            mSurfaceVariant = base01;
            mOnSurfaceVariant = base04;
            mOutline = base03;
            mShadow = base00;
            terminal = {};
          };
        };
      };
    };
  };
}
