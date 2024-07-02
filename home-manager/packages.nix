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
}
