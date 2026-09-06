{
  self,
  inputs,
  den,
  ...
}: {
  den.hosts.x86_64-linux.lookfar.users.araucaria = {};

  den.aspects.lookfar = {
    includes = [
      den.batteries.hostname

      den.aspects.preservation
      den.aspects.environment
      den.aspects.unfree
      den.aspects.zram
      den.aspects.desktop
      den.aspects.desktop-extra
      den.aspects.limine
      den.aspects.plymouth
      den.aspects.kernel
    ];

    nixos = {
      pkgs,
      config,
      lib,
      ...
    }: {
      imports = [
        inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
        self.modules.generic.library
        self.diskoConfigurations.lookfar
      ];

      time.timeZone = "Europe/London";
      i18n.defaultLocale = "en_GB.UTF-8";

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
    };
  };
}
