{
  pkgs,
  lib,
  ...
}: let 
  set_alacritty_color = pkgs.writeShellScript "set_alacritty_color" ''
    SCHEME=$(cat /home/fu1lp0w3r/.cache/ags/options.json | grep scheme | awk -F ":" '{print $2}' | sed "s/\"//g" | sed "s/,//g" | sed "s/ //g")
    BG=$(cat /home/fu1lp0w3r/.cache/ags/options.json | grep "theme.$SCHEME.bg" | awk -F ":" '{print $2}' | sed "s/\"//g" | sed "s/,//g" | sed "s/ //g")
    FG=$(cat /home/fu1lp0w3r/.cache/ags/options.json | grep "theme.$SCHEME.fg" | awk -F ":" '{print $2}' | sed "s/\"//g" | sed "s/,//g" | sed "s/ //g")
    alacritty msg config "colors.primary.background=\"$BG\"" 
    alacritty msg config "colors.primary.foreground=\"$FG\""
  ''; 
in {
  home.sessionVariables.TERMINAL = "alacritty";
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary = {
          background = "0x171717";
          foreground = "0xb2b5b3";
        };
        normal = {
          black = "0x373839";
          red = "0xe55f86";
          green = "0x00D787";
          yellow = "0xEBFF71";
          blue = "0x51a4e7";
          magenta = "0x9077e7";
          cyan = "0x51e6e6";
          white = "0xe7e7e7";
        };
        bright = {
          black = "0x313234";
          red = "0xd15577";
          green = "0x43c383";
          yellow = "0xd8e77b";
          blue = "0x4886c8";
          magenta = "0x8861dd";
          cyan = "0x43c3c3";
          white = "0xb2b5b3";
        };
        cursor = {
          text = "0xffffff";
          background = "0xe7e7e7";
        };
        selection = {
          text = "0xffffff";
          background = "0x313234";
        };
      };
      window = {
        opacity = 0.9;
        padding = {
          x = 12;
          y = 12;
        };
      };
      font = {
        normal.family = "CaskaydiaCove Nerd Font";
        size = 12;
      };
      shell = {
        program = "${pkgs.nushell}/bin/nu";
        args = [
          "-l"
          "-c"
          "zsh ${set_alacritty_color}; tmux"
        ];
      };
    };
  };
}
