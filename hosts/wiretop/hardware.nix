{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "usb_storage"
    "sd_mod"
    "sdhci_pci"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.systemd.enable = true;
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c94d0961-d23a-44e2-b948-a23af7d0345d";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."root" = {
    device = "/dev/disk/by-uuid/faa34ed7-6d4d-45ca-8a9c-b0c01eff7c9e";
    crypttabExtraOpts = [ "fido2-device=auto" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/E3F9-13FA";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = lib.singleton {
    device = "/dev/disk/by-uuid/dc22753e-27ee-4d5b-85ec-2a955e75733a";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
