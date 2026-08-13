{
  flake.modules.nixos.plymouth = {
    boot = {
      plymouth.enable = true;

      consoleLogLevel = 0;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
	"rd.udev.log_level=3"
	"rd.systemd.show_status=auto"
      ];

      loader.timeout = 1;
    };

    systemd.services = {
      systemd-udev-settle.enable = false;
      NetworkManager-wait-online.enable = false;
    };
  };
}
