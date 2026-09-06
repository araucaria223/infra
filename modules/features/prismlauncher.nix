{
  den.aspects.prismlauncher.nixos = {pkgs, ...}: {
    users.users.araucaria.packages = [
      pkgs.prismlauncher
    ];
  };

  den.aspects.preservation.nixos = {config, ...}: {
    preservation.preserveAt."/persistent" = {
      users.${config.users.users.araucaria.name}.directories = [
        ".local/share/PrismLauncher"
      ];
    };
  };
}
