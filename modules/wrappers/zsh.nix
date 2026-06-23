{self, ...}: {
  flake.wrappers.zsh = {
    pkgs,
    lib,
    wlib,
    ...
  }: {
    imports = [wlib.wrapperModules.zsh];
    hmSessionVariables = null;

    zshAliases = rec {
      ls = "${lib.getExe pkgs.eza} --follow-symlinks";
      lsa = "${ls} -la";
      lst = "${ls} --tree --icons";
      cat = "${lib.getExe pkgs.bat} --theme=base16";
      f = "${lib.getExe pkgs.fastfetch} -c examples/9.jsonc";
      v = "nvim";
    };

    zshrc.content = "
      	eval \"$(${lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.starship} init zsh)\"
      ";
  };
}
