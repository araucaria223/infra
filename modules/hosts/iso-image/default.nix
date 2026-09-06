{
  self,
  inputs,
  den,
  moduleWithSystem,
  ...
}: {
  den.hosts.x86_64-linux.iso-image = {
    hostName = "live";
    users.araucaria = {};
  };

  den.aspects.iso-image = {
    includes = [
      den.batteries.hostname

      den.aspects.environment
      den.aspects.zram
      den.aspects.desktop
    ];

    nixos = moduleWithSystem (
      {self', ...}: {
        pkgs,
        config,
        lib,
        ...
      }: {
        imports = [
          (inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
          self.modules.generic.library
        ];

        users.users.nixos.enable = false;
        time.timeZone = "Europe/London";
        i18n.defaultLocale = "en_GB.UTF-8";

        boot.kernelPackages = pkgs.linuxPackages_latest;

        system.stateVersion = "26.05";

        services.greetd = {
          enable = true;
          settings.initial_session = {
            user = config.users.users.araucaria.name;
            command = lib.getExe self'.packages.desktop;
          };
        };
      }
    );
  };
}
