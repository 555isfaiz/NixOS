{inputs, ...}: {
  home = {
    sessionVariables.BROWSER = "firefox";

    file."firefox-gnome-theme" = {
      target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
      source = inputs.firefox-gnome-theme;
    };
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      name = "Default";
      settings = {
        "browser.tabs.loadInBackground" = true;
        "widget.gtk.rounded-bottom-corners.enabled" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "gnomeTheme.hideSingleTab" = true;
        "gnomeTheme.bookmarksToolbarUnderTabs" = true;
        "gnomeTheme.normalWidthTabs" = false;
        "gnomeTheme.tabsAsHeaderbar" = false;
      };
      userChrome = ''
        @import "firefox-gnome-theme/userChrome.css";
      '';
      userContent = ''
        @import "firefox-gnome-theme/userContent.css";
      '';
    };
  };

  programs.google-chrome = {
    enable = true;
    commandLineArgs = [
      "--ozone-platform=wayland"
      "--use-gl=angle"
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
