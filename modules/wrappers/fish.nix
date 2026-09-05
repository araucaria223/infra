{
  lib,
  moduleWithSystem,
  self,
  ...
}: {
  flake.wrappers.fish = moduleWithSystem ({self', ...}: {
    pkgs,
    wlib,
    config,
    ...
  }: {
    imports = [wlib.wrapperModules.fish];

    options.theme = lib.mkOption {
      default = self.theme;
    };

    config = {
      runtimePkgs = with pkgs; [zoxide devenv];

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

      shellAliases = {
        ls = "${lib.getExe pkgs.eza} --icons --follow-symlinks";
        cat = "${lib.getExe pkgs.bat} --theme=base16";
        v = lib.getExe pkgs.neovim;
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
          position = "anywhere";
        };

        lsa = "ls -la";
        lst = "ls --tree";
      };

      configFile.content = with config.theme.paletteNoHash;
      # fish
        ''
          fish_vi_key_bindings

          ${lib.getExe pkgs.zoxide} init fish | source

          ${lib.getExe pkgs.devenv} hook fish | source

          ${lib.getExe pkgs.nix-your-shell} --nom fish | source

          set -g fish_color_normal ${base05}
          set -g fish_color_error ${base08}
          set -g fish_color_command ${base0D}
          set -g fish_color_param ${base0A}
          set -g fish_color_quote ${base0B}
          set -g fish_color_redirection ${base0C}
          set -g fish_color_end ${base09}
          set -g fish_color_operator ${base0E}
          set -g fish_color_escape ${base0E}
          set -g fish_color_autosuggestion ${base03}
          set -g fish_color_comment ${base03}
          set -g fish_color_valid_path --underline
          set -g fish_color_selection --background=${base02} ${base05}
          set -g fish_color_search_match --background=${base02} ${base05}

          set -g fish_pager_color_prefix ${base0D}
          set -g fish_pager_color_completion ${base05}
          set -g fish_pager_color_description ${base03}
          set -g fish_pager_color_progress ${base0C}
          set -g fish_pager_color_secondary ${base04}
        '';
    };
  });
}
