{...}: {
  flake.modules.nixos.mullvad-vpn = {pkgs, ...}: {
    services = {
      resolved.enable = true;
      mullvad-vpn = {
        enable = true;
	package = pkgs.mullvad-vpn;
	};
      };

    preservation.preserveAt."/persistent" = {
      directories = [
        {
	  directory = "/etc/mullvad-vpn";
	  mode = "0700";
	}
      ];
      users.araucaria.directories = [
        ".config/Mullvad VPN"
    ];
    };
  };
}
