{
  self,
  inputs,
  lib,
  ...
}: {
  flake-file.inputs.nix-index-database = {
    url = "github:Mic92/nix-index-database";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.environment = {pkgs, ...}: {
    imports = [
      self.modules.nixos.ssh
      inputs.nix-index-database.nixosModules.nix-index
      self.modules.nixos.determinate
    ];

    programs.nix-index-database.comma.enable = true;

    nix = let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
      channel.enable = false;
      registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
      settings = {
        flake-registry = "";
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
    };

    environment.systemPackages = [
      pkgs.devenv
    ];

    programs.nix-ld = {
      enable = true;
    };
  };
}
