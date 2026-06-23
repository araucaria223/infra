{inputs, ...}: {
  imports = [
    inputs.disko.flakeModules.default
    inputs.flake-parts.flakeModules.modules
  ];

  systems = [
    "x86_64-linux"
  ];
}
