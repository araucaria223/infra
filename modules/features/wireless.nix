{den, ...}: {
  den.aspects.wireless.includes = [
    den.aspects.mullvad-vpn
  ];

  den.aspects.wireless.nixos = {
    networking.networkmanager = {
      enable = true;
      wifi.powersave = true;
    };

    users.users.araucaria.extraGroups = ["networkmanager"];
  };

  den.aspects.preservation.nixos = {
    preservation.preserveAt."/persistent".directories = [
      "/etc/NetworkManager/system-connections"
    ];
  };
}
