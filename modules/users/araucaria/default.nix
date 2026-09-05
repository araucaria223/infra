{moduleWithSystem, ...}: {
  flake.modules.nixos.araucaria = moduleWithSystem (
    {self', ...}: {...}: {
      services.userborn.enable = true;

      users = {
        mutableUsers = false;
        users.araucaria = {
          uid = 1000;
          isNormalUser = true;
          initialPassword = "password1";
          hashedPasswordFile = "/persistent/passwd";
          extraGroups = ["wheel"];
          shell = self'.packages.environment;
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHTNS3bsK/k/svOc8YCIvahRTOViOZXEcUX3ctgWlxGa max.allfrey@gmail.com"
          ];
        };
      };
    }
  );

  flake.modules.nixos.preservation = {config, ...}: {
    preservation.preserveAt."/persistent".users.${config.users.users.araucaria.name} = {
      commonMountOptions = ["x-gvfs-hide"];
      directories = [
        {
          directory = ".ssh";
          mode = "0700";
        }
        {
          directory = ".config/mozilla";
          configureParent = true;
          parent = {
            user = config.users.users.araucaria.name;
            group = "users";
            mode = "0755";
          };
        }

        {
          directory = ".local/share/keyrings";
          configureParent = true;
          parent = {
            user = config.users.users.araucaria.name;
            group = "users";
            mode = "0755";
          };
        }
      ];
    };
  };
}
