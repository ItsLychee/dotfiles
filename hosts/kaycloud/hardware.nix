# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "virtio_pci"
    "virtio_scsi"
    "sr_mod"
    "virtio_blk"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/e5d9dc37-f5fb-4c73-bfcd-32a83437c512";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/1F39-F297";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/1f6673ed-3d62-4237-9607-3b3a84305ba9"; }
  ];
  networking.useDHCP = false;
  systemd.network = {
    enable = true;
    networks.wan = {
      matchConfig.MACAddress = "00:50:56:00:27:7B";
      dns = [
        "1.1.1.1"
        "1.0.0.1"
      ];
      addresses = [
        { Address = "78.46.83.227/27"; }
        { Address = "2a01:4f8:120:11e6::2/64"; }
      ];
      routes = [
        { Gateway = "fe80::1"; }
        { Gateway = "78.46.83.225"; }
      ];

    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
