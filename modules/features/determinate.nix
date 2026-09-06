{inputs, ...}: {
  flake-file.inputs.determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

  den.aspects.determinate.nixos = {
    imports = [inputs.determinate.nixosModules.default];
  };
}
