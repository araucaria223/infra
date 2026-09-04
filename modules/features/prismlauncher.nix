{
  flake.modules.nixos.prismlauncher = {pkgs, ...}: {
    users.users.araucaria.packages = [pkgs.prismlauncher];
  };

  flake.modules.nixos.preservation = {config, ...}: {
    preservation.preserveAt."/persistent" = {
      users.${config.users.users.araucaria.name}.directories = [
        ".local/share/PrismLauncher"
      ];
    };
  };
}
