{
  den.aspects.mullvad-vpn.nixos = {
    services = {
      resolved.enable = true;
      mullvad-vpn = {
        enable = true;
      };
    };
  };

  den.aspects.preservation.nixos = {
    preservation.preserveAt."/persistent" = {
      directories = [
        {
          directory = "/etc/mullvad-vpn";
          mode = "0700";
        }
        "/var/cache/mullvad-vpn"
      ];
      users.araucaria.directories = [
        ".config/Mullvad VPN"
      ];
    };
  };
}
