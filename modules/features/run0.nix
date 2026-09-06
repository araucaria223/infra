{
  den.aspects.run0.nixos = {
    security = {
      sudo.enable = false;
      run0 = {
        enable = true;
        persistentAuth.enable = true;
        sudo-shim.enable = true;
      };
    };
  };
}
