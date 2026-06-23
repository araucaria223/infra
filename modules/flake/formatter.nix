{inputs, ...}: {
  flake-file.inputs.treefmt-nix.url = "github:numtide/treefmt-nix";

  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem.treefmt = {
    projectRootFile = "flake.nix";
    programs = {
      alejandra.enable = true;
      nixf-diagnose = {
        enable = true;
        variableLookup = true;
        ignore = ["sema-unused-def-lambda-witharg-formal"];
      };

      deadnix = {
        enable = true;
        no-lambda-pattern-names = true;
      };
    };

    settings.formatter = {
      alejandra = {
        priority = 2;
        excludes = ["flake.nix"];
      };
      nixf-diagnose = {
        priority = 1;
        excludes = ["flake.nix"];
      };
      deadnix = {
        priority = 0;
        excludes = ["flake.nix"];
      };
    };
  };
}
