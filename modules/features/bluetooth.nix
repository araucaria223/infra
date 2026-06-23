{...}: {
  flake.modules.nixos.bluetooth = {...}: {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };

  flake.modules.nixos.preservation = {...}: {
    preservation.preserveAt."/persistent".directories = [
      "/var/lib/bluetooth"
    ];
  };
}
