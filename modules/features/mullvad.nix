{...}: {
  flake.modules.nixos.mullvad-vpn = {...}: {
    services = {
      resolved.enable = true;
      mullvad-vpn = {
        enable = true;
        gui.enable = true;
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
