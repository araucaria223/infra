{
  inputs,
  lib,
  self,
  moduleWithSystem,
  ...
}: {
  flake-file.inputs.niri-animations = {
    url = "github:jgarza9788/niri-animation-collection?dir=animations";
    flake = false;
  };

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
        type = lib.types.package;
        default = pkgs.kitty;
      };

      theme = lib.mkOption {
        default = self.theme;
      };
    };

    config.extraSettings = [
      {animations.slowdown = 0.5;}
    ];

    config.settings = let
      noctalia = lib.getExe perSystem.self'.packages.noctalia-v5;
      ipc = args: [noctalia "msg"] ++ args;
      mullvad = lib.getExe pkgs.mullvad-vpn;
      psst = lib.getExe' perSystem.self'.packages.psst-unwrapped;
      #polkit-auth = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
    in {
      xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

      include = "${inputs.niri-animations}/pixelate.kdl";

      spawn-at-startup = [
        (psst "psst-keyring-prompter")
        (psst "psst-polkit-agent")
        noctalia
        mullvad
      ];

      hotkey-overlay.skip-at-startup = _: {};
      debug = {
        honor-xdg-activation-with-invalid-serial = _: {};
      };

      cursor = {
        xcursor-theme = "${pkgs.phinger-cursors}/share/icons/phinger-cursors-dark";
        xcursor-size = 20;
      };

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

      window-rules = [
        {geometry-corner-radius = 5;}
        {clip-to-geometry = true;}
        {
          matches = [
            {app-id = "dev.noctalia.Noctalia";}
          ];
          open-floating = true;
          default-column-width = {fixed = 1080;};
          default-window-height = {fixed = 920;};
        }
      ];

      layer-rules = [
        {
          matches = [
            {namespace = "^noctalia-backdrop";}
          ];
          place-within-backdrop = true;
        }
      ];

      switch-events = {
        lid-close = {
          spawn = ipc ["session" "lock-and-suspend"];
        };
      };
    };
  });
}
