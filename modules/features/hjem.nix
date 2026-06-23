{inputs, ...}: {
  flake-file.inputs.hjem.url = "github:feel-co/hjem";

  flake.modules.nixos.hjem = {
    imports = [inputs.hjem.nixosModules.default];

    hjem.clobberByDefault = true;
  };
}
