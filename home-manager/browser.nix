{inputs, ...}: {
  home = {
    sessionVariables.BROWSER = "firefox";

    file."firefox-shyfox" = {
      target = ".mozilla/firefox/default/chrome/firefox-shyfox";
      source = inputs.firefox-gnome-theme;
    };
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      name = "Default";
      settings = {
        "browser.tabs.loadInBackground" = false;
        "widget.gtk.rounded-bottom-corners.enabled" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "layout.css.has-selector.enabled" = true;
        "browser.urlbar.suggest.calculator" = true;
        "browser.urlbar.unitConversion.enabled" = true;
        "browser.urlbar.trimHttps" = true;
        "browser.urlbar.trimURLs" = true;
        "widget.gtk.ignore-bogus-leave-notify" = 1;
        "gnomeTheme.hideSingleTab" = true;
        "gnomeTheme.bookmarksToolbarUnderTabs" = true;
        "gnomeTheme.normalWidthTabs" = false;
        "gnomeTheme.tabsAsHeaderbar" = false;
      };
      userChrome = ''
        @import "firefox-shyfox/chrome/userChrome.css";
      '';
      userContent = ''
        @import "firefox-shyfox/chrome/userContent.css";
      '';
    };
  };

  programs.google-chrome = {
    enable = true;
    commandLineArgs = [
      "--ozone-platform=wayland"
      "--use-gl=angle"
      # "--ozone-platform=x11"
      # "--enable-gpu-rasterization"
      "--enable-accelerated-video-decode"
      "--enable-accelerated-2d-canvas"
      "--enable-features=VaapiVideoDecodeLinuxGL"
      # "--enable-raw-draw"
      #"--enable-native-gpu-memory-buffers"
      "--enable-zero-copy"
      "--ignore-gpu-blocklist"
    ];
  };
}
