{ config, lib, pkgs, ...}:
{
  # Mixins
  imports = [
    (import ../../mixins/openssh.nix { allowedUsers = [ "lychee"]; })
    ../../mixins/hardware.nix
    ../../mixins/security.nix
    ../../mixins/systemd-boot.nix
    ../../mixins/pipewire.nix
    ../../mixins/fonts.nix
  ];
  time.hardwareClockInLocalTime = true;
  time.timeZone = "US/Central";

  networking = {
    hostName = "embassy";
    firewall.enable = true;
    networkmanager.enable = true;
    networkmanager.enableFccUnlock = true;
  };
  # User(s)
  users.users.lychee = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "storage" "networkmanager" "adbusers" ];
    openssh.authorizedKeys.keyFiles = [ ../../keys.pub ];
  };

  # System wide programs
  programs.dconf.enable = true;
  programs.adb.enable = true;
  # Enable SSH agent
  programs.ssh.startAgent = true;
  programs.ssh.agentTimeout = "1h";

  # Zsh config
  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh.enable = true;
  # Services
  services.udisks2.enable = true;
  services.tor.enable = true;

  # Swaylock privileges
  security.pam.services.swaylock.text = ''
    # PAM configuration file for the swaylock screen locker. By default, it includes
    # the 'login' configuration file (see /etc/pam.d/login)
    auth include login
  '';

  # Internal storage devices
  fileSystems."/storage" = {
    device = "/dev/disk/by-label/Storage";
    fsType = "ntfs";
  };
  # System packages
  environment.systemPackages = with pkgs; [ neovim scrcpy tor-browser-bundle-bin ];
}
