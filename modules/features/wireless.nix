{
  flake.modules.nixos.wireless = {...}: {
    networking.networkmanager = {
      enable = true;
      wifi.powersave = true;
    };

    users.users.araucaria.extraGroups = ["networkmanager"];
  };

  flake.modules.nixos.preservation = {...}: {
    preservation.preserveAt."/persistent".directories = [
      "/etc/NetworkManager/system-connections"
    ];
  };
}
