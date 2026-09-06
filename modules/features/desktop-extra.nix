{
  den,
  moduleWithSystem,
  ...
}: {
  flake.modules.generic.library.library.allowedUnfreePackages = [
    "stremio-server"
    "stremio-service"
  ];

  den.aspects.desktop-extra.includes = [
    den.aspects.spotify
    den.aspects.prismlauncher
    den.aspects.steam
  ];

  den.aspects.desktop-extra.nixos = moduleWithSystem ({self', ...}: {pkgs, ...}: {
    users.users.araucaria.packages = with pkgs; [
      vscodium
      vesktop
      element-desktop
      stremio-service
      self'.packages.mpv
    ];
  });
}
