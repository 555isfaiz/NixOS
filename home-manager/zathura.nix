{pkgs, config, ...}: {
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      recolor = true;
      recolor-reverse-video = true;
      recolor-keephue = true;
      scroll-step = 100;
    };
  };
  xdg = {
    desktopEntries."zathura" = {
      name = "Zathura";
      comment = "PDF reader";
      icon = "zathura";
      exec = "xterm -e ${pkgs.neovim}/bin/nvim %F";
      categories = ["Application"];
      terminal = true;
      mimeType = ["application/pdf"];
    };
  };
}
