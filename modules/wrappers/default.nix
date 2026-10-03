{inputs, ...}: {
  flake-file.inputs.wrapper-modules = {
    url = "github:nix-community/nix-wrapper-modules";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  imports = [inputs.wrapper-modules.flakeModules.wrappers];
}
