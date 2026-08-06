{inputs, ...}: {
  flake-file.inputs.wrapper-modules = {
    url = "github:BirdeeHub/nix-wrapper-modules";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  imports = [inputs.wrapper-modules.flakeModules.wrappers];
}
