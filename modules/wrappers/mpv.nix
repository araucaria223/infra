{self, lib, ...}: {
  flake.wrappers.mpv = {
    config,
    wlib,
    pkgs,
    ...
  }: {
    imports = [wlib.wrapperModules.mpv];

    options.theme = lib.mkOption {
      default = self.theme;
    };

    config = {
      "mpv.conf".content = ''
        save-position-on-quit=yes
      '';
      script = with pkgs; {
      modernz = {
        path = mpvScripts.modernz;
	opts = with config.theme.palette; {
	  window_top_bar = false;
	  layout = "mini";
	  idlescreen = "yes";

	  osc_color = base00;
	  window_title_color = base07;
	  window_controls_color = base07;
	  windowcontrols_close_hover = base08;
	  windowcontrols_max_hover = base0A;
	  windowcontrols_min_hover = base0B;
	  title_color = base07;
	  seekbar_cache_color = base04;
	  seekbarfg_color = base09;
	  seekbarbg_color = base03;
	  seek_handle_color = base0F;
	  seek_handle_border_color = base09;
	  time_color = base07;
	  chapter_title_color = base07;
	  cache_info_color = base07;
	  side_buttons_color = base07;
	  middle_buttons_color = base07;
	  playpause_color = base07;
	  held_element_color = base03;
	  hover_effect_color = base09;
	  thumbnail_box_color = base01;
	  thumbnail_box_outline = base02;
	  nibble_color = base09;
	  nibble_current_color = base07;
	  ab_loop_color = base0D;
	};
      };

      thumbfast.path = mpvScripts.thumbfast;
      autosubsync.path = mpvScripts.autosubsync-mpv;
      autosub.path = mpvScripts.autosub;
      mpris.path = mpvScripts.mpris;
      sponsorblock.path = mpvScripts.sponsorblock;
      quality-menu.path = mpvScripts.quality-menu;
      memo.path = mpvScripts.memo;
      "webtorrent-mpv-hook" = {
        path = mpvScripts.webtorrent-mpv-hook;
	opts = {
	  path = "/tmp/webtorrent";
	};
      };
    };
  };
  };
}
