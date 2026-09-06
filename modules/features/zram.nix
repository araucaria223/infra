{
  den.aspects.zram.nixos = {
    zramSwap = {
      enable = true;
      priority = 100;
      memoryPercent = 50;
    };
  };
}
