{
  lib,
  modulesPath,
  pkgs,
  ...
}: let
  inherit (lib) mkForce;
in {
  # Support LVM
  boot.kernelModules = [
    "dm-snapshot"
    "dm-mod"
    "dm-cache"
    "dm-cache-default"
  ];

  isoImage.isoBaseName = mkForce "configuration";
  networking.networkmanager.enable = true;
  networking.wireless.enable = mkForce false;

  services.kmscon.autologinUser = "lychee";

  hey = {
    caps = {
      rootLogin = true;
      headless = true;
    };
    # Disable defaults that don't make sense here
    users.lychee.usePasswdFile = mkForce false;
    net.fail2ban = mkForce false;
  };

  # for nixos-anywhere
  environment.systemPackages = [pkgs.rsync];
}
