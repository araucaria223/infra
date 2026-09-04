{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.lookfar = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
      self.modules.generic.library
      self.diskoConfigurations.lookfar

      self.modules.nixos.araucaria
      self.modules.nixos.preservation
      self.modules.nixos.environment
      self.modules.nixos.unfree
      self.modules.nixos.zram
      self.modules.nixos.desktop
      self.modules.nixos.desktop-extra
      self.modules.nixos.limine
      self.modules.nixos.plymouth


      ({pkgs, config, lib, ...}: {
        networking.hostName = "lookfar";
        time.timeZone = "Europe/London";
        i18n.defaultLocale = "en_GB.UTF-8";

        boot.kernelPackages = pkgs.linuxPackages_latest;
        services.fwupd = {
          enable = true;
          extraRemotes = ["lvfs-testing"];
          uefiCapsuleSettings.DisableCapsuleUpdateOnDisk = true;
        };

        hardware.facter.reportPath = ./facter.json;

        services.greetd = lib.mkIf (config.specialisation != {}) {
          enable = true;
          useTextGreeter = true;
          settings.default_session = {
            user = "greeter";
            command = lib.getExe' pkgs.tuigreet "tuigreet";
          };
        };

        system.stateVersion = "26.05";
      })
    ];
  };
}
