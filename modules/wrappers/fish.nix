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

    plugins = [pkgs.fishPlugins.hydro];

    shellAliases = rec {
      ls = "${lib.getExe pkgs.eza} --icons --follow-symlinks";
      lst = "${ls} --tree --icons";
      cat = "${lib.getExe pkgs.bat} --theme=base16";
      v = lib.getExe self'.packages.neovim;
    };

    abbreviations = {
      d = "cd ~/Downloads";
      infracd = {
        word = "infra";
        expansion = "cd ~/Projects/infra";
        position = "command";
      };
      infra = {
        expansion = "~/Projects/infra";
        command = "*";
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
  #  perSystem = {
  #    pkgs,
  #    lib,
  #    ...
  #  }: {
  #    packages.fish = inputs.wrapper-modules.wrappers.fish.wrap {
  #      inherit pkgs;
  #      runtimePkgs = [pkgs.zoxide];
  #
  #      shellAliases = rec {
  #        ls = "${lib.getExe pkgs.eza} --icons --follow-symlinks";
  #        lst = "${ls} --tree --icons";
  #        cat = "${lib.getExe pkgs.bat} --theme=base16";
  #        v = "nvim";
  #      };
  #
  #      abbreviations = {
  #        d = "cd ~/Downloads";
  #        infra = "cd ~/Projects/infra";
  #        lsa = "ls -la";
  #	lst = "ls --tree";
  #      };
  #
  #      configFile.content =
  #        # fish
  #        ''
  #          function fish_prompt
  #              string join "" -- (set_color red) "[" (set_color yellow) $USER (set_color green) "@" (set_color blue) $hostname (set_color magenta) " " $(prompt_pwd) (set_color red) ']' (set_color normal) "\$ "
  #          end
  #
  #          set fish_greeting
  #          fish_vi_key_bindings
  #
  #          ${lib.getExe pkgs.zoxide} init fish | source
  #
  #          if type -q direnv
  #            direnv hook fish | source
  #          end
  #        '';
  #    };
  #  };
}
