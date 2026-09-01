{self, ...}: {
  flake.wrappers.noctalia = {config, ...}: {
    imports = [self.wrapperModules.noctalia-wrapper];

    settings = {
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

      dock.enabled = false;

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
      };
    };
  };
}
