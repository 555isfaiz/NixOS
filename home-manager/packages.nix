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
      spotify
      vlc
      gnome-secrets
      fragments
      # yabridge
      # yabridgectl
      # wine-staging
      nodejs
    ];
    cli = [
      python3
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
