{
  self,
  moduleWithSystem,
  ...
}: {
  flake.modules.generic.library.library.allowedUnfreePackages = [
    "stremio-server"
    "stremio-service"
  ];

  flake.modules.nixos.desktop-extra = moduleWithSystem ({self', ...}: {pkgs, ...}: {
    imports = [
      self.modules.nixos.spotify
      self.modules.nixos.prismlauncher
      self.modules.nixos.steam
    ];

    users.users.araucaria.packages = with pkgs; [
      vscodium
      vesktop
      element-desktop
      stremio-service
      self'.packages.mpv
    ];
  });
}
