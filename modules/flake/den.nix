{inputs, ...}: {
  imports = [
    (inputs.den.flakeModules.dendritic or {})
  ];

  flake-file.inputs.den.url = "github:denful/den";
}
