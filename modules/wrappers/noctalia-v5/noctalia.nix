{moduleWithSystem, ...}: {
  flake-file.inputs.noctalia.url = "github:noctalia-dev/noctalia/cachix";
  flake.nixConfig = {
    extra-substituters = ["https://noctalia.cachix.org"];
    extra-trusted-public-keys = ["noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="];
  };

  flake.wrappers.noctalia-v5 = moduleWithSystem ({inputs', ...}: {wlib, ...}: {
    imports = [wlib.modules.default];
    package = inputs'.noctalia.packages.default;

    env.NOCTALIA_CONFIG_HOME = ./config;
  });
}
