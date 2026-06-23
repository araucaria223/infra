{inputs, ...}: {
  imports = [
    inputs.flake-file.flakeModules.dendritic
  ];

  flake-file.inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-file.url = "github:vic/flake-file";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
