{moduleWithSystem, ...}: {
  flake.modules.nixos.araucaria = moduleWithSystem (
    {self', ...}: {config, ...}: {
      users.users.araucaria = {
        name = "araucaria";
        isNormalUser = true;
        initialPassword = "password1";
        extraGroups = ["wheel"];
        shell = self'.packages.environment;
	openssh.authorizedKeys.keys = [
	  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHTNS3bsK/k/svOc8YCIvahRTOViOZXEcUX3ctgWlxGa max.allfrey@gmail.com"
	];
      };

      hjem.users.araucaria = {
        enable = true;
        user = "araucaria";
        directory = "/home/araucaria";
      };

      preservation.preserveAt."/persistent".users.${config.users.users.araucaria.name} = {
        commonMountOptions = ["x-gvfs-hide"];
        directories = [
          # XDG User Directories
          "Desktop"
          "Documents"
          "Downloads"
          "Music"
          "Pictures"
          "Projects"
          "Public"
          "Templates"
          "Videos"

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
        ];
      };
    }
  );
}
