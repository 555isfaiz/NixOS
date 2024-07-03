{pkgs, ...}: {
  imports = [
    ./modules/packages.nix
    ./scripts/blocks.nix
    ./scripts/nx-switch.nix
    ./scripts/vault.nix
  ];

  packages = with pkgs; {
    linux = [
      (mpv.override {scripts = [mpvScripts.mpris];})
      vlc
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
      (callPackage ./fehviewer.nix {})
      xdg-user-dirs
      python3
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
      icon = "fehviewer";
      exec = "${pkgs.neovim}/bin/fehviewer";
      categories = ["Adult"];
      terminal = false;
    };
  };
}
