{ pkgs, config, ... }:
{
  config.programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    profiles = {
      lychee = {
        isDefault = true;
        bookmarks = {
           "HM Options".url = "https://rycee.gitlab.io/home-manager/options.html";
        };
        settings = {
          "devtools.theme" = "white";
          "services.sync.prefs.sync.browser.uiCustomization.state" = true;
          "signon.rememberSignons" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "extensions.htmlaboutaddons.discover.enabled" = false;
          "extensions.pocket.enabled" = false;
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
          "extensions.shield-recipe-client.enabled" = false;
          "app.shield.optoutstudies.enabled" = false;
          "reader.parse-on-load.enabled" = false;
          "browser.search.hiddenOneOffs" = "Google,Amazon.com,Bing,DuckDuckGo,eBay,Wikipedia (en)";

          # general settings
          "browser.tabs.inTitlebar" = 1;
          "general.autoScroll" = true;
          "general.smoothScroll" = false;
          "browser.fullscreen.autohide" = false;
          "browser.aboutConfig.showWarning" = false;

          # remove the bullshit firefox inserts
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.section.topsites" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.urlbar.sponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.search.suggest.enabled" = false;
          "browser.urlbar.quicksuggest.enabled" = false;
          "browser.urlbar.quicksuggest.remoteSettings.enabled" = false;

          # Shortcuts in URL bar
          "browser.urlbar.shortcuts.bookmarks" = false;
          "browser.urlbar.shortcuts.tabs" = false;
          "browser.urlbar.shortcuts.history" = false;

          "browser.urlbar.suggest.engines" = false;

          # quick find
          "accessibility.typeaheadfind.manual" = false;
          "accessibility.typeaheadfind" = false;
          "accessibility.typeaheadfind.autostart" = false;

          # Fontconfig
          "font.size.variable.x-western" = 14;

          # Autofill
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;

          # Beacon async http transfers
          "beacon.enabled" = false;
          "browser.send_pings" = true;
          # Domain guessing
          "browser.fixup.alternate.enabled" = false;

          # Telemetry & experiments
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "experiments.supported" = false;
          "experiments.enabled" = false;
          "experiments.manifest.uri" = "";

          # Health reports
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.healthreport.service.enabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
        };
      };
    };
  };

}
