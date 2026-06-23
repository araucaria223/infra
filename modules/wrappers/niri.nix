{
  lib,
  self,
  moduleWithSystem,
  ...
}: {
  flake.wrappers.niri = moduleWithSystem (perSystem @ {
    self',
    config,
    ...
  }: {
    wlib,
    pkgs,
    config,
    ...
  }: {
    imports = [wlib.wrapperModules.niri];

    options = {
      terminal = lib.mkOption {
        type = lib.types.str;
        default = "kitty";
      };

      theme = lib.mkOption {
        default = self.theme;
      };
    };

    config.settings = let
      noctalia = lib.getExe perSystem.self'.packages.noctalia;
      polkit-auth = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
    in {
      xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

      spawn-at-startup = [polkit-auth noctalia];

      hotkey-overlay.skip-at-startup = _: {};

      input = {
        keyboard.xkb.layout = "us";

        touchpad = {
          tap = _: {};
          dwt = _: {};
          dwtp = _: {};
          click-method = "clickfinger";
          drag = true;
        };

        trackball = {
          scroll-method = "on-button-down";
          scroll-button = 279;
        };

        focus-follows-mouse = _: {};
      };

      gestures.hot-corners.off = _: {};
      prefer-no-csd = _: {};

      layout = with config.theme.palette; {
        gaps = 5;
        background-color = base00;

        focus-ring = {
          width = 2;
          active-color = base0D;
          inactive-color = base03;
          urgent-color = base0C;
        };
      };

      binds = let
        bind = title: content: _: {
          props.hotkey-overlay-title = title;
          inherit content;
        };

        norepeat = title: content: _: {
          props = {
            hotkey-overlay-title = title;
            repeat = false;
          };

          inherit content;
        };

        locked = title: content: _: {
          props = {
            hotkey-overlay-title = title;
            allow-when-locked = true;
          };

          inherit content;
        };

        window = action: direction: let
          obj =
            if builtins.elem direction ["up" "down"]
            then "window"
            else "column";
        in
          norepeat "${lib.toSentenceCase action} ${obj} ${direction}"
          (lib.mapAttrs' (_n: v: lib.nameValuePair "${action}-${obj}-${direction}" v) {
            _ = _: {};
          });

        ipc = args: [noctalia "ipc" "call"] ++ args;
      in
        {
          "Mod+Space" = norepeat "Launcher" {
            spawn = ipc ["launcher" "toggle"];
          };

          "Mod+Return" = norepeat "Terminal" {
            spawn = [config.terminal];
          };

          "Mod+D" = norepeat "Launch chords" {
            spawn-sh = perSystem.config.library.mkWhichKeyExe {
              inherit (config) theme;
              menu = [
                {
                  key = "b";
                  desc = "Bluetooth";
                  cmd = "${noctalia} ipc call bluetooth togglePanel";
                }
                {
                  key = "w";
                  desc = "Wifi";
                  cmd = "${noctalia} ipc call network togglePanel";
                }
                {
                  key = "f";
                  desc = "Firefox";
                  cmd = lib.getExe pkgs.firefox;
                }
              ];
            };
          };

          "Mod+Shift+L" = norepeat "Lock screen" {
            spawn = ipc ["lockScreen" "lock"];
          };

          "XF86AudioRaiseVolume" = locked "Raise volume" {
            spawn = ipc ["volume" "increase"];
          };

          "XF86AudioLowerVolume" = locked "Lower volume" {
            spawn = ipc ["volume" "decrease"];
          };

          "XF86AudioMute" = locked "Mute playback" {
            spawn = ipc ["volume" "muteOutput"];
          };

          "XF86MonBrightnessUp" = locked "Increase brightness" {
            spawn = ipc ["brightness" "increase"];
          };

          "XF86MonBrightnessDown" = locked "Decrease brightness" {
            spawn = ipc ["brightness" "decrease"];
          };

          "Mod+W" = norepeat "Window switcher" {
            spawn = ipc ["launcher" "windows"];
          };

          "Mod+Q" = norepeat "Close window" {
            close-window = _: {};
          };
          "Mod+F" = norepeat "Fullscreen window" {
            fullscreen-window = _: {};
          };
          "Mod+Shift+F" = norepeat "Windowed fullscreen" {
            toggle-windowed-fullscreen = _: {};
          };
          "Mod+M" = norepeat "Maximise column" {
            maximize-column = _: {};
          };

          "Mod+Equal" = bind "Increase column width" {
            set-column-width = "+10%";
          };

          "Mod+Minus" = bind "Decrease column width" {
            set-column-width = "-10%";
          };

          "Mod+Shift+Equal" = bind "Increase window height" {
            set-window-height = "+10%";
          };

          "Mod+Shift+Minus" = bind "Decrease window height" {
            set-window-height = "-10%";
          };

          "Mod+Left" = window "focus" "left";
          "Mod+Down" = window "focus" "down";
          "Mod+Up" = window "focus" "up";
          "Mod+Right" = window "focus" "right";

          "Mod+H" = window "focus" "left";
          "Mod+J" = window "focus" "down";
          "Mod+K" = window "focus" "up";
          "Mod+L" = window "focus" "right";

          "Mod+Ctrl+Left" = window "move" "left";
          "Mod+Ctrl+Down" = window "move" "down";
          "Mod+Ctrl+Up" = window "move" "up";
          "Mod+Ctrl+Right" = window "move" "right";

          "Mod+Ctrl+H" = window "move" "left";
          "Mod+Ctrl+J" = window "move" "down";
          "Mod+Ctrl+K" = window "move" "up";
          "Mod+Ctrl+L" = window "move" "right";

          "Mod+Home" = window "focus" "first";
          "Mod+End" = window "focus" "last";
          "Mod+Ctrl+Home" = window "move" "to-first";
          "Mod+Ctrl+End" = window "move" "to-last";

          "Mod+G" = window "focus" "first";
          "Mod+SemiColon" = window "focus" "last";
          "Mod+Ctrl+G" = window "move" "to-first";
          "Mod+Ctrl+SemiColon" = window "move" "to-last";

          "Mod+WheelScrollRight" = window "focus" "right";
          "Mod+WheelScrollLeft" = window "focus" "left";
          "Mod+Ctrl+WheelScrollRight" = window "move" "right";
          "Mod+Ctrl+WheelScrollLeft" = window "move" "left";

          "Mod+Escape" = _: {
            props = {
              hotkey-overlay-title = "Escape keybind inhibitor";
              allow-inhibiting = false;
            };

            content.toggle-keyboard-shortcuts-inhibit = _: {};
          };

          "Mod+S" = norepeat "Screenshot (region)" {screenshot = _: {};};
          "Mod+Shift+S" = norepeat "Screenshot (window)" {
            screenshot-window = _: {};
          };
          "Print" = norepeat "Screenshot (screen)" {screenshot-screen = _: {};};
        }
        // builtins.listToAttrs (builtins.concatMap (x: let
          wksp = toString x;
        in [
          {
            name = "Mod+${wksp}";
            value = _: {
              props = {
                hotkey-overlay-title = "Focus workspace ${wksp}";
                repeat = false;
              };

              content = {focus-workspace = x;};
            };
          }
          {
            name = "Mod+Shift+${wksp}";
            value = _: {
              props = {
                hotkey-overlay-title = "Move window to workspace ${wksp}";
                repeat = false;
              };

              content = {move-window-to-workspace = x;};
            };
          }
        ]) (lib.range 1 9));
    };
  });
}
