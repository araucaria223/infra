{
  flake.modules.nixos.searxng = {pkgs, ...}: {
    services.searx = {
      enable = true;
      package = pkgs.searxng;
      environmentFile = "/home/araucaria/Documents/.searxng.env";

      redisCreateLocally = true;
      settings.server = {
        bind_address = "::1";
	port = "5000";
      };
    };
  };
}
