{moduleWithSystem, ...}: {
  flake-file.inputs.nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

  flake.modules.nixos.kernel = moduleWithSystem ({inputs', ...}: {
    pkgs,
    lib,
    ...
  }: {
    nix.settings = {
      substituters = ["https://cache.lantian.pub/lantian"];
      trusted-public-keys = ["lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ="];
    };

    boot.kernelPackages = let
      baseKernel = inputs'.nix-cachyos-kernel.legacyPackages.linux-cachyos-bore-lto-x86_64-v3;

      minimalKernel = baseKernel.overrideAttrs (_oldAttrs: {
        structuredExtraConfig = with lib.kernel; {
          DRM_AMDGPU = no;
          DRM_NOUVEAU = no;

          XFS_FS = no;
          INFINIBAND = no;
          HYPERV = no;
        };
      });
    in
      pkgs.linuxKernel.packagesFor minimalKernel;
  });
}
