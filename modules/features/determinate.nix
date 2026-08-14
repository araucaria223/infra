{inputs, ...}: {
  flake-file.inputs.determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

  flake.modules.nixos.determinate = {
    imports = [inputs.determinate.nixosModules.default];
  };
}
