{
  flake.modules.nixos.prismlauncher = {pkgs, config, ...}: {
    users.users.araucaria.packages = [pkgs.prismlauncher];

    preservation.preserveAt."/persistent" = {
      users.${config.users.users.araucaria.name}.directories = [
        ".local/share/PrismLauncher"
      ];
    };
  };
}
