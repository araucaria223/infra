{
  flake.wrappers.noctalia.settings = {
    bar.side = {
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
      end = ["tray" "privacy" "group:system-info" "clock"];
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
      privacy.hide_inactive = true;

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
}
