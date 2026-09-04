{
  self,
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosConfigurations.iso-image = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      (inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix")
      self.modules.generic.library

      self.modules.nixos.environment
      self.modules.nixos.zram
      self.modules.nixos.desktop
      self.modules.nixos.araucaria

      (moduleWithSystem ({self', ...}: {
        pkgs,
        config,
        lib,
        ...
      }: {
        networking.hostName = "live";
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
      }))
    ];
  };
}
