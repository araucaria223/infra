{
  flake.modules.nixos.libron = {pkgs, ...}: {
    fonts.packages = [
      (pkgs.callPackage ./_package.nix {})
    ];
  };
}
