{
  flake.modules.nixos.run0 = {
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
