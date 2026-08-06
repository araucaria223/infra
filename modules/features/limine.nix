{self, ...}: {
  flake.modules.nixos.limine = {pkgs, ...}: {
    boot.loader.limine = {
      enable = true;
    };

    # Needed to set up secure boot
    environment.systemPackages = [pkgs.sbctl];
  };

  flake.modules.nixos.preservation = {...}: {
    preservation.preserveAt."/persistent".directories = [
      "/var/lib/sbctl"
    ];
  };
}
