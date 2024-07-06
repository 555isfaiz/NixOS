{pkgs, config, ...}: {
  programs.zathura = {
    enable = true;
    options = {
      completion-bg = "#363A4F";
      completion-fg = "#b2b5b3";
      completion-highlight-bg = "#575268";
      completion-highlight-fg = "#b2b5b3";
      completion-group-bg = "#363A4F";
      completion-group-fg = "#8AADF4";

      notification-bg = "#363A4F";
      notification-fg = "#b2b5b3";

      inputbar-fg = "#b2b5b3";
      inputbar-bg = "#363A4F";

      recolor-lightcolor = "#171717";
      recolor-darkcolor = "#b2b5b3";

      index-fg = "#b2b5b3";
      index-bg = "#171717";
      index-active-fg = "#b2b5b3";
      index-active-bg = "#363A4F";

      render-loading-bg = "#171717";
      render-loading-fg = "#b2b5b3";
      default-bg = "#171717";
      default-fg = "#b2b5b3";
      highlight-color = "#575268";
      highlight-fg = "#F5BDE6";
      highlight-active-color = "#F5BDE6";
      statusbar-bg = "#171717";
      statusbar-fg = "#b2b5b3";
      selection-clipboard = "clipboard";
      recolor = true;
      recolor-reverse-video = true;
      recolor-keephue = true;
      scroll-step = 100;
    };
  };
  # xdg = {
  #   desktopEntries."zathura" = {
  #     name = "Zathura";
  #     comment = "PDF reader";
  #     icon = "evince";
  #     exec = "xterm -e ${pkgs.zathura}/bin/zathura %F";
  #     categories = ["Application"];
  #     terminal = true;
  #     mimeType = ["application/pdf"];
  #   };
  # };
}
