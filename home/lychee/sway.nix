{ pkgs, lib, hostname, ...}@attrs:
{
  imports = [
    ./sway-keybindings.nix
    ./sway-outputs.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.sway-unwrapped.overrideAttrs (_: rec {
      version = "1.8-rc3";
      src = pkgs.fetchFromGitHub {
        owner = "swaywm";
        repo = "sway";
        rev = version;
        sha256 = "sha256-ltmlD8R/Dsv80+f3olHeRFOYlrHdcfMa19CfYADqSfI=";
      };
    });
    systemdIntegration = true;
    wrapperFeatures.gtk = true;
    extraConfig = ''
      for_window {
        # Applications
        [app_id="^launcher$"] floating enable, sticky enable, resize set 30 ppt 60 ppt, border pixel 1
        [app_id="gcolor3"] floating enable, sticky enable, border pixel 0.5

        # File Dialogs
        [title="(?:Open|Save) (?:File|Folder|As)"] floating enable, resize set width 1030 height 710

        # Firefox
        [app_id="firefox" title="^Picture-in-Picture$"] floating enable; sticky enable
      }
      input "type:touchpad" {
        tap enabled
        scroll_method two_finger
      }
      input "type:keyboard" {
        dwt enabled
      }
      workspace 1
    '';
    config = {
      fonts = {
        names = [ "Iosevka" "Font Awesome 6 Free" ];
        style = "Regular";
        size = 9.0;
      };
      bars = [];
      gaps = {
        outer = 1;
        inner = 1;
      };
      focus.followMouse = "no";
      colors.focused = rec {
          border = background;
          background = "#FFA9D2";
          text = "#e8e8e8";
          indicator = "#2e9ef4";
          childBorder = "#915b75";
      };
    };
  };
}
