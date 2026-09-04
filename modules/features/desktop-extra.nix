{self, ...}: {
  flake.modules.nixos.desktop-extra = {pkgs, ...}: {
    imports = [
      self.modules.nixos.spotify
      self.modules.nixos.prismlauncher
      self.modules.nixos.steam
    ];

    users.users.araucaria.packages = with pkgs; [
      vscodium
      vesktop
      stremio-linux-shell
      element-desktop
    ];
  };
}
