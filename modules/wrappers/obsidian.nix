{self, ...}: {
  flake.modules.generic.library.library.allowedUnfreePackages = [
    "obsidian"
  ];

  flake.wrappers.obsidian = {pkgs, wlib, ...}: {
    imports = [wlib.modules.default];

    config.package = pkgs.obsidian;

    config.runtimePkgs = [
      (pkgs.texliveSmall.withPackages (ps: with ps; [
      	luatex
	lualatex-math
      ]))
      pkgs.pandoc
    ];
  };

  flake.modules.nixos.preservation = {config, ...}: {
    preservation.preserveAt."/persistent".users.${config.users.users.araucaria.name}.directories = [
      ".config/obsidian"
    ];
  };
}
