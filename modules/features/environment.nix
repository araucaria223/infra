{
  den,
  inputs,
  lib,
  ...
}: {
  flake-file.inputs.nix-index-database = {
    url = "github:Mic92/nix-index-database";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.environment.includes = [
    den.aspects.ssh
    den.aspects.run0
    den.aspects.determinate
  ];

  den.aspects.environment.nixos = {pkgs, ...}: {
    imports = [
      inputs.nix-index-database.nixosModules.nix-index
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
      pkgs.nix-output-monitor
    ];

    programs.nix-ld = {
      enable = true;
    };
  };
}
