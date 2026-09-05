{
  flake.modules.nixos.xdg = {
    pkgs,
    lib,
    ...
  }: {
    environment.etc."xdg/user-dirs.defaults".text = ''
      DESKTOP=.
      TEMPLATES=.
      PUBLICSHARE=.
      DOWNLOAD=Downloads
      DOCUMENTS=Documents
      MUSIC=Media/Music
      PICTURES=Media/Pictures
      VIDEOS=Media/Videos
      PROJECTS=Projects
    '';

    systemd.user.services.xdg-user-dirs = {
      description = "Update XDG user directories";
      wantedBy = ["graphical-session-pre.target"];
      unitConfig = {
        ConditionUser = "!@system";
        RequiresMountsFor = "/home";
      };
      serviceConfig = {
        Type = "oneshot";
        ExecStart = lib.getExe' pkgs.xdg-user-dirs "xdg-user-dirs-update";
      };
    };
  };

  flake.modules.nixos.preservation = {config, ...}: {
    preservation.preserveAt."/persistent".users.${config.users.users.araucaria.name}.directories = [
      "Documents"
      "Downloads"
      "Projects"
      "Media"
    ];
  };
}
