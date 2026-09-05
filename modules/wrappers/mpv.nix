{
  flake.wrappers.mpv = {wlib, pkgs, ...}: {
    imports = [wlib.wrapperModules.mpv];

    script = with pkgs; {
      modernz.path = mpvScripts.modernz;
      thumbfast.path = mpvScripts.thumbfast;
      autosubsync.path = mpvScripts.autosubsync-mpv;
      autosub.path = mpvScripts.autosub;
      mpris.path = mpvScripts.mpris;
      sponsorblock.path = mpvScripts.sponsorblock;
      quality-menu.path = mpvScripts.quality-menu;
      webtorrent.path = mpvScripts.webtorrent-mpv-hook;
    };
  };
}
