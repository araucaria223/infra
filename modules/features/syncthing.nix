{
  flake.modules.nixos.syncthing = {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      guiPasswordFile = "/persistent/syncthing-passwd";
      user = "araucaria";
      configDir = "/home/araucaria/.config/syncthing";
      dataDir = "/home/araucaria";

      settings = {
        gui.user = "araucaria";
        options.urAccepted = -1;

        devices.phone.id = "KPMHPFX-QNL3L54-Q4AL4GW-DSRYKGW-36277JH-WYMT6RZ-QPEZOGG-BLWROAU";

        folders."Sync" = {
          path = "/home/araucaria/Documents/Sync";
          devices = ["phone"];
        };
      };
    };
  };

  flake.modules.nixos.preservation = {config, ...}: {
    preservation.preserveAt."/persistent".users.${config.users.users.araucaria.name}.directories = [
      ".config/syncthing"
    ];
  };
}
