{
  den.aspects.spotify.nixos = {pkgs, ...}: {
    services.spotifyd = {
      enable = true;
      settings = {
        backend = "pipe";
        bitrate = 320;
      };
    };

    users.users.araucaria.packages = [pkgs.spotatui];
  };
}
