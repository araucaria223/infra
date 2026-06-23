{
  withSystem,
  inputs,
  self,
  ...
}: {
  perSystem = {
    system,
    lib,
    config,
    ...
  }: {
    imports = [self.modules.generic.library];
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) config.library.allowedUnfreePackages;
    };
  };

  flake.modules.nixos.unfree = {config, ...}: {
    nixpkgs.pkgs = withSystem config.nixpkgs.hostPlatform.system (
      {pkgs, ...}: pkgs
    );
  };
}
