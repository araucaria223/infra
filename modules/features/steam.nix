{
  flake.modules.generic.library.library.allowedUnfreePackages = [
    "steam"
    "steam-unwrapped"
  ];

  flake.modules.nixos.preservation = {config, ...}: {
    preservation.preserveAt."/persistent".users.${config.users.users.araucaria.name}.directories = [
      ".steam"
      ".local/share/Steam"
    ];
  };

  flake.modules.nixos.steam = {
    pkgs,
    config,
    lib,
    ...
  }: {
    specialisation."Steam".configuration = {
      environment.etc."specialisation".text = "Steam";

      programs = {
        gamemode.enable = true;

        gamescope = {
          enable = true;
          capSysNice = true;
        };

        steam = {
          enable = true;
          gamescopeSession = {
            enable = true;
            args = [
              "-W"
              "2256"
              "-H"
              "1504"
              "-f"
              "-e"
              "--xwayland-count"
              "2"
              "--hdr-enabled"
              "--hdr-itm-enabled"
            ];
            steamArgs = [
              "-pipewire-dmabuf"
              "-gamepadui"
              "-steamdeck"
              "-steamos3"
              "-mangoapp"
            ];
          };
        };
      };

      services.greetd = {
        enable = true;
        settings.default_session = {
          command = "${lib.getExe pkgs.gamescope} -W 1920 -H 1080 -w 1280 -h 720 -f -e --xwayland-count 2 --hdr-enabled --hdr-itm-enabled -F fsr -- steam -pipewire-dmabuf -gamepadui -steamdeck -steamos3 > /dev/null 2>&1";
          user = config.users.users.araucaria.name;
        };
      };
    };
  };
}
