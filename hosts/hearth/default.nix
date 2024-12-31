{ pkgs, inputs, ... }:
{
  boot = {
    kernelParams = [ "irqpoll" ];
    loader.systemd-boot.enable = true;
    binfmt.emulatedSystems = [
      "aarch64-linux"
    ];
  };

  hey = {
    graphical.games = true;
    hostKeys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOaAxiB8BtVJC+3WM/ydH+8CRaINbE+7X3aO1l/0cJhV";
    users.lychee = {
      groups = [
        "docker"
        "adbusers"
      ];
    };
  };

  programs.wireshark.enable = true;

  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      nix-tree
      vesktop
      nixpkgs-review
      winetricks
      # android-studio
      act
      libreoffice
      ;
  };
  programs.adb.enable = true;
  virtualisation.docker.enable = true;

  hardware = {
    bluetooth.enable = true;
    keyboard.qmk.enable = true;
  };

  networking.networkmanager.enable = true;

  imports = [ inputs.cosmic.nixosModules.default ];

  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
  nix.settings = {
    substituters = [ "https://cosmic.cachix.org/" ];
    trusted-public-keys = [
      "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
    ];
  };

  # services.desktopManager.plasma6 = {
  #   enable = true;
  #   enableQt5Integration = true;
  # };
  # services.displayManager.sddm = {
  #   enable = true;
  #   wayland.enable = true;
  # };
  # NOTE: Leave this, this seems to fix the issues with the current set kernel such as but not limited to:
  # - Stuttering app performance
  # - Elite Dangerous doesn't want to run
  # - Bad audio
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.fstrim.enable = true;

  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  # hey.remote.use = true;

}
