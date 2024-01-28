{
  config,
  pkgs,
  modulesPath,
  ...
}: {
  
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  hardware.cpu.amd.updateMicrocode = true;
  boot = {
    kernelModules = ["kvm-amd"];
    extraModulePackages = with pkgs; [rtw88-firmware];
    kernelParams = ["irqpoll"];
    initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "sd_mod" "sr_mod"];
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 20;
    loader.systemd-boot = {
      enable = true;
      editor = false;
      consoleMode = "max";
    };
  };
  time.timeZone = "US/Central";
  time.hardwareClockInLocalTime = true;

  services.minidlna = {
    enable = true;
    openFirewall = true;
    settings = {
      friendly_name = "The Desktop";
      media_dir = [
        "/storage/media/"
        "/home/lychee/torrents/"
      ];
      inotify = "yes";
      enable_tivo = "yes";
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NixOS";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/Boot";
      fsType = "vfat";
    };
    "/storage" = {
      device = "/dev/disk/by-label/Storage";
      fsType = "ntfs";
    };
  };

  programs.ssh = {
    startAgent = true;
    enableAskPassword = true;
  };

  shell.fish = true;
  system.sound = true;
  graphical = {
    fonts.enable = true;
    fonts.defaults = true;
    enable = true;
  };
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  hardware.keyboard.qmk.enable = true;

  # SSH
  servers.ssh.enable = true;
  servers.ssh.allowedUsers = ["lychee"];
  # Users
  users.users.lychee = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = ["wheel" "storage" "networkmanager" "adbusers"];
  };
}
