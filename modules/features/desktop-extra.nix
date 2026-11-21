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
      self.modules.nixos.searxng
      self.modules.nixos.libron
    ];

    users.users.araucaria.packages = with pkgs; [
      vscodium
      vesktop
      element-desktop
      stremio-service
      #self'.packages.mpv
      self'.packages.obsidian
    ];
  });

  flake.modules.nixos.preservation = {config, ...}: {
    preservation.preserveAt."/persistent".users.${config.users.users.araucaria.name}.directories = [
      ".config/VSCodium"
      ".vscode-oss"
      ".vscode-oss-shared"

      # Definitely does not go here
      ".elan"
    ];
  };
}
