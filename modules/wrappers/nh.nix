{
  flake.wrappers.nh = {wlib, ...}: {
    imports = [wlib.wrapperModules.nh];

    flake = "~/Projects/infra";
  };
}
