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
      zed-editor
      netease-cloud-music-gtk
      blueman
      vscode-fhs
      blender
      unityhub
      # gnome-secrets
      # yabridge
      # yabridgectl
      # wine-staging
      nodejs
    ];
    cli = [
      usql
      pyright
      jdt-language-server
      gamemode
      clang-tools
      docker-compose
      msgpack-tools
      nitch
      socat
      jdk
      gradle
      maven
      gcc
      cmake
      gnumake
      fehviewer
      xdg-user-dirs
      python312
      python312Packages.pip
      ruff
      ruff-lsp  
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
