{...}: {
  flake.wrappers.git = {wlib, ...}: {
    imports = [wlib.wrapperModules.git];

    settings = {
      user = {
        name = "Max Allfrey";
        email = "max.allfrey@gmail.com";
	signingKey = "key::ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHTNS3bsK/k/svOc8YCIvahRTOViOZXEcUX3ctgWlxGa max.allfrey@gmail.com";
      };

      gpg.format = "ssh";
      commit.gpgsign = true;

      init.defaultBranch = "main";
    };
  };
}
