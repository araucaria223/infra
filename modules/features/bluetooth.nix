{
  den.aspects.bluetooth.nixos = {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };

  den.aspects.preservation.nixos = {
    preservation.preserveAt."/persistent".directories = [
      "/var/lib/bluetooth"
    ];
  };
}
