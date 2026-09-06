{
  den.aspects.ssh.nixos = {
    services.openssh = {
      enable = true;

      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };
  };
}
