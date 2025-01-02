{ config, lib, ... }:
let
  inherit (lib) mkIf;
  inherit (config) services;
in
{
  config =
    mkIf services.caddy.enable
    || services.nginx.enable {
      networking.firewall = {
        allowedTCPPorts = [
          80
          443
        ];
        allowedUDPPorts = [ 443 ]; # QUIC
      };
    };

}
