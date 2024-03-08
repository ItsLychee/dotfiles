{
  lib,
  modulesPath,
  mylib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkForce;
in {
  imports = [(modulesPath + "/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix")];
  networking.networkmanager.enable = true;
  networking.wireless.enable = mkForce false;
  users.users = {
    root.openssh.authorizedKeys.keys = mylib.keys.privileged config.hey.keys.users.lychee;
  };

  environment.systemPackages = [pkgs.rsync];
}
