{
  self,
  inputs,
  ...
}: {
  flake-file.inputs.nix-index-database.url = "github:Mic92/nix-index-database";

  flake.modules.nixos.environment = {...}: {
    imports = [
      self.modules.nixos.ssh
      inputs.nix-index-database.nixosModules.nix-index
      self.modules.nixos.nixbuild
    ];

    programs.nix-index-database.comma.enable = true;

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    programs.nix-ld = {
      enable = true;
    };
  };
}
