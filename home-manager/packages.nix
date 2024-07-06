{pkgs, ...}: 
let fehviewer = (pkgs.callPackage ./fehviewer.nix {}); in {
  imports = [
    ./modules/packages.nix
    ./scripts/blocks.nix
    ./scripts/nx-switch.nix
    ./scripts/vault.nix
  ];
  
  packages = with pkgs; {
    linux = [
      (mpv.override {scripts = [mpvScripts.mpris];})
      yesplaymusic
      blueman
      vscode
      blender
      unityhub
      gnome-secrets
      # yabridge
      # yabridgectl
      # wine-staging
      nodejs
    ];
    cli = [
      neofetch
      socat
      jdk
      maven
      gcc
      cmake
      gnumake
      fehviewer
      xdg-user-dirs
      python312
      python312Packages.pip
      feh
      bat
      eza
      fd
      ripgrep
      fzf
      lazydocker
      lazygit
    ];
  };
  xdg = {
    desktopEntries."fehviewer" = {
      name = "fehviewer";
      comment = "Ehentai";
      icon = "nvim";
      exec = "${fehviewer}/bin/fehviewer";
      categories = ["Adult"];
      terminal = false;
    };
  };
}
