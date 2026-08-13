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

      loader.timeout = 0;
    };
  };
}
