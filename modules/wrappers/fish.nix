{
  lib,
  moduleWithSystem,
  ...
}: {
  flake.wrappers.fish = moduleWithSystem ({self', ...}: {
    pkgs,
    wlib,
    ...
  }: {
    imports = [wlib.wrapperModules.fish];
    runtimePkgs = [pkgs.zoxide];

    plugins = with pkgs.fishPlugins; [
      pure
      async-prompt
      autopair
      #bobthefisher
      colored-man-pages
      done
      fish-you-should-use
      bang-bang
    ];

    shellAliases = rec {
      ls = "${lib.getExe pkgs.eza} --icons --follow-symlinks";
      cat = "${lib.getExe pkgs.bat} --theme=base16";
      v = lib.getExe self'.packages.neovim;
    };

    abbreviations = {
      d = "cd ~/Downloads";
      infra = {
        word = "infra";
        expansion = "cd ~/Projects/infra";
        position = "command";
      };

      find-extension = {
        word = "ext";
        expansion = ". -name '*.%'";
        command = "find";
        cursor = true;
      };

      lsa = "ls -la";
      lst = "ls --tree";
    };

    configFile.content =
      # fish
      ''
        fish_vi_key_bindings

        ${lib.getExe pkgs.zoxide} init fish | source

        if type -q direnv
          direnv hook fish | source
        end
      '';
  });
}
