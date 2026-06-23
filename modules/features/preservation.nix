{inputs, ...}: {
  flake-file.inputs.preservation.url = "github:nix-community/preservation";

  flake.modules.nixos.preservation = {...}: {
    imports = [
      inputs.preservation.nixosModules.default
    ];

    preservation = {
      enable = true;

      preserveAt."/persistent" = {
        files = [
          {
            file = "/etc/machine-id";
            inInitrd = true;
            how = "symlink";
            configureParent = true;
          }
        ];

        directories = [
          "/var/lib/systemd/timers"
          "/var/log"
          {
            directory = "/tmp";
            mode = "1777";
            mountOptions = ["noexec" "nodev"];
          }
          {
            directory = "/var/lib/nixos";
            inInitrd = true;
          }
        ];
      };
    };

    systemd = {
      suppressedSystemUnits = ["systemd-machine-id-commit.service"];

      # let the service commit the transient ID to the persistent volume
      services.systemd-machine-id-commit = {
        unitConfig.ConditionPathIsMountPoint = [
          ""
          "/persistent/etc/machine-id"
        ];
        serviceConfig.ExecStart = [
          ""
          "systemd-machine-id-setup --commit --root /persistent"
        ];
      };
    };
  };
}
