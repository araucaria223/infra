{
  flake.modules.generic.library.library.allowedUnfreePackages = [
    "steam"
    "steam-unwrapped"
  ];

  flake.modules.nixos.steam = {pkgs, config, lib, ...}: {
    specialisation.steam.configuration = {
      environment.etc."specialisation".text = "steam";

      programs = {
        gamemode.enable = true;

        gamescope = {
	  enable = true;
	  capSysNice = true;
	};

	steam = {
	  enable = true;
	  gamescopeSession.enable = true;
	};
	
	noctalia-greeter.enable = lib.mkForce false;
	niri.enable = lib.mkForce false;
      };

      services.greetd = {
        enable = true;
	settings.default_session = {
	command = "${lib.getExe pkgs.gamescope} -W 1920 -H 1080 -f -e --xwayland-count 2 --hdr-enabled --hdr-itm-enabled -- steam -pipewire-dmabuf -gamepadui -steamdeck -steamos3 > /dev/null 2>&1";
        user = config.users.users.araucaria.name;
      };
    };
    };
  };
}
