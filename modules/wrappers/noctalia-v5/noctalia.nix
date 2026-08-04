{
  self,
  moduleWithSystem,
  ...
}: {
  flake-file.inputs.noctalia.url = "github:noctalia-dev/noctalia/cachix";

  flake.wrappers.noctalia-v5 = moduleWithSystem ({inputs', ...}: {...}: {
    imports = [self.wrapperModules.noctalia-wrapper];
    package = inputs'.noctalia.packages.default;

    settings = fromTOML (builtins.readFile ./config.toml);
  });
}
