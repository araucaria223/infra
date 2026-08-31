{self, ...}: {
  flake.wrappers.psst = {
    imports = [self.wrapperModules.psst-wrapper];

    allowAny = true;

    theme = with self.theme.palette; {
      backdrop.background = "${base00}60";

      window = {
        background = base00;
        border = base02;
        border-width = 2;
        radius = 16;
        padding = {
          x = 28;
          y = 26;
        };
        gap = 20;
        shadow = {
          color = "#00000090";
          blur = 25;
          spread = 10;
          offset-x = 0;
          offset-y = 15;
        };

        text = base05;
        title.size = 24;
        icon = {
          background = "${base0D}70";
          text = base06;
          radius = 8;
          size = 24;
          padding = {
            x = 10;
            y = 10;
          };
        };

        description-label = {
          text = base03;
          size = 13;
        };

        description-value = {
          text = base04;
          size = 13;
        };

        error = {
          text = base08;
          background = "${base08}20";
          radius = 6;
          size = 13;
          padding = {
            x = 12;
            y = 8;
          };
        };

        field = {
          background = base01;
          placeholder = base03;
          selection = "${base05}60";
          border = base02;
          border-width = 2;
          radius = 8;
          font = "JetBrains Mono Nerd Font";
          size = 15;
          padding = {
            x = 13;
            y = 11;
          };
          focus = {
            border = base0D;
            background = base01;
          };
        };

        reveal = {
          text = base0C;
          size = 20;
        };

        strength = {
          background = base02;
          radius = 3;
          size = 6;
        };

        strength-weak.background = base08;
        strength-medium.background = base09;
        strength-strong.background = base0A;

        checkbox = {
          background = base01;
          text = base04;
          border = base02;
          border-width = 1;
          radius = 4;
          size = 16;
          focus.border = base0D;
          checked = {
            text = base05;
            border = base02;
          };
        };

        confirm = {
          background = "${base0D}70";
          text = base06;
          radius = 6;
          size = 13;
          padding = {
            x = 18;
            y = 9;
          };
          hover.background = "${base0D}b0";
          active.background = "${base0D}95";
        };

        cancel = {
          background = "${base02}05";
          text = base04;
          radius = 6;
          size = 13;
          padding = {
            x = 12;
            y = 9;
          };
          hover.background = "${base02}12";
          active.background = "${base02}09";
        };

        hint-key = {
          text = base04;
          size = 12;
        };

        hint-word = {
          text = base0F;
          size = 12;
        };
      };
    };
  };
}
