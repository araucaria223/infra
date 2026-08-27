{
  flake.modules.nixos.zram = { config, pkgs, ... }: {
    zramSwap = {
      enable = true;
      priority = 100;
      memoryPercent = 50;
    };
  };
}
