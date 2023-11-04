{ config, pkgs, ...}:
{
  imports = [
    ../../mixins/security.nix
    (import ../../mixins/openssh.nix { allowedUsers = ["pi"]; })
  ];


  boot = {
    initrd.kernelModules = [ "vc4" "bcm2835_dma" "i2c_bcm2835" ];
    kernelParams = [ "console=ttyS1,115200n8" ];
    loader.grub.enable = false;
    loader.generic-extlinux-compatible = {
      enable = true;
      configurationLimit = 10;
    };
  };
  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh.enable = true;
  users.users.pi = {
    isNormalUser = true;
    openssh.authorizedKeys.keyFiles = [ ../../keys.pub ];
    shell = pkgs.zsh;
    extraGroups = [ "wheel"];
  };
  networking = {
    hostName = "fruitpie";
    firewall.enable = true;
    networkmanager.enable = true;
    networkmanager.enableFccUnlock = true;
  };

  nix.buildMachines = [
    {
      hostName = "embassy";
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      maxJobs = 4;
      speedFactor = 10;
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
    }
  ];

  programs.ssh.extraConfig = ''
  Host builder
    HostName 192.168.0.8
    User remote-builder
    IdentitiesOnly yes
    IdentifyFile /root/.ssh/id_ed25519
  '';
}
