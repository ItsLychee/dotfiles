{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkDefault mkMerge mkIf;
  inherit (config.services.tailscale) interfaceName;
in {
  config = mkMerge [
    {
      services.tailscale = {
        enable = true;
        useRoutingFeatures = "both";
        openFirewall = true;
      };
      services.openssh.enable = mkDefault config.hey.caps.headless;
      # https://github.com/NixOS/nixpkgs/issues/180175#issuecomment-1658731959
      systemd.services.NetworkManager-wait-online.serviceConfig = {
        ExecStart = ["" "${pkgs.networkmanager}/bin/nm-online -q"];
      };
      systemd.network.wait-online.ignoredInterfaces = [interfaceName];
      networking.networkmanager.enable = true;
    }

    (mkIf config.services.tailscale.enable {
      services.openssh.openFirewall = mkDefault false;
      networking.firewall.interfaces.${interfaceName} = {
        allowedTCPPorts = [22];
      };
    })
  ];
}
