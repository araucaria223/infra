{...}: {
  flake.modules.nixos.limine = {...}: {
    boot.loader.limine = {
      enable = true;
    };
  };
}
