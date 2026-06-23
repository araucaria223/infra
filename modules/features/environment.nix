{self, ...}: {
  flake.modules.nixos.environment = {...}: {
    imports = [
      self.modules.nixos.ssh
    ];

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
