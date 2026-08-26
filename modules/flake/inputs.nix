{inputs, ...}: {
  imports = [
    inputs.flake-file.flakeModules.dendritic
  ];

  flake-file.inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    flake-file.url = "github:vic/flake-file";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-compat.follows = "";
  };
}
