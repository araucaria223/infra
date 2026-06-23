{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.lookfar = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
      self.modules.generic.library
      self.modules.nixos.lookfar-hardware
      self.diskoConfigurations.lookfar

      self.modules.nixos.araucaria
      self.modules.nixos.hjem
      self.modules.nixos.preservation
      self.modules.nixos.environment
      self.modules.nixos.unfree
      self.modules.nixos.desktop

      ({pkgs, ...}: {
        networking.hostName = "lookfar";
        time.timeZone = "Europe/London";
        i18n.defaultLocale = "en_GB.UTF-8";

        boot.loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };

        boot.kernelPackages = pkgs.linuxPackages_latest;
        services.fwupd = {
          enable = true;
          extraRemotes = ["lvfs-testing"];
          uefiCapsuleSettings.DisableCapsuleUpdateOnDisk = true;
        };

        system.stateVersion = "26.05";
      })
    ];
  };
}
