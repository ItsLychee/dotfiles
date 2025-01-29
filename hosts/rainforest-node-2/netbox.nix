{
  pkgs,
  config,
  lib,
  ...
}:
{

  deployment.keys.netbox-secret = {
    destDir = "/var/lib/secrets/netbox";
    user = "netbox";
    group = "netbox";
    keyCommand = [
      "gpg"
      "--decrypt"
      (toString ../../secrets/netbox-secret.gpg)
    ];
  };
  deployment.keys.netbox-ldap= {
    destDir = "/var/lib/secrets/netbox";
    user = "netbox";
    group = "netbox";
    keyCommand = [
      "gpg"
      "--decrypt"
      (toString ../../secrets/netbox-ldap.gpg)
    ];
  };

  services.netbox = {
    enable = true;
    package = pkgs.netbox;
    settings = {
      CSRF_TRUSTED_ORIGINS = [ "https://netbox.ratlabs.co" ];
      LOGGING = {
        "version"= 1;
        "disable_existing_loggers"= false;
        "handlers"= {
            "netbox_auth_log"= {
                "level"= "DEBUG";
                "class"= "logging.handlers.RotatingFileHandler";
                "filename"= "/var/lib/netbox/debug.log";
                "maxBytes"= 1024 * 500;
                "backupCount"= 5;
            };
        };
        "loggers"= {
            "django_auth_ldap"= {
                "handlers"= ["netbox_auth_log"];
                "level"= "DEBUG";
            };
        };
        };
    };
    enableLdap = true;
    ldapConfigPath = config.deployment.keys.netbox-ldap.path;

    secretKeyFile = config.deployment.keys.netbox-secret.path;
  };

  services.caddy = {
    enable = true;
    virtualHosts."netbox.ratlabs.co".extraConfig = ''
      route /static* {
        uri strip_prefix /static
        root * ${config.services.netbox.dataDir}/static
        file_server
      }
      @server not path /static*
      reverse_proxy @server ${config.services.netbox.listenAddress}:${toString config.services.netbox.port}
      encode gzip zstd
      log {
        level error
      }
      tls {
        ca https://ca.ratlabs.co/acme/acme/directory
      }
    '';
  };

  users.groups.netbox.members = [ config.services.caddy.user ];
}
