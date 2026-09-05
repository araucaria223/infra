{...}: {
  flake-file.inputs.goxore = {
    url = "github:goxore/nixconf";
    inputs = {
      nixpkgs.follows = "nixpkgs";
      nixpkgs-stable.follows = "";
      flake-parts.follows = "flake-parts";
      impermanence.follows = "";
      persist-retro.follows = "";
      disko.follows = "";
      nix-index-database.follows = "";
      wrapper-modules.follows = "wrapper-modules";
      hjem.follows = "";
      nix-gaming.follows = "";
      nixpkgs-multiverse.follows = "";
    };
  };

  flake.wrappers.neovim = {wlib, ...}: {
    imports = [wlib.wrapperModules.neovim];
  };
}
