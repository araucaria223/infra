{
  flake.wrappers.yazi = {wlib, pkgs, ...}: {
    imports = [wlib.wrapperModules.yazi];

    plugins = with pkgs.yaziPlugins; {
      inherit drag yatline mediainfo ouch full-border;
    };
  };
}
