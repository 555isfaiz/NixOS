{username}: {config, ...}: {
  news.display = "show";

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    warn-dirty = false;
  };

  home = {
    sessionVariables = {
      NVD_BACKEND = "direct";
      NIXOS_OZONE_WL = "1";
      LIBVA_DRIVER_NAME = "nvidia";
      QT_QPA_PLATFORM = "wayland";
      GBM_BACKEND = "nvidia-drm";
      GBM_BACKEND_PATH = "/run/opengl-driver/lib/gbm";
      __GL_GSYNC_ALLOWED = "1";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXPKGS_ALLOW_INSECURE = "1";
      BAT_THEME = "base16";
      GOPATH = "${config.home.homeDirectory}/.local/share/go";
      GOMODCACHE = "${config.home.homeDirectory}/.cache/go/pkg/mod";
    };

    sessionPath = [
      "$HOME/.local/bin"
    ];
  };

  gtk.gtk3.bookmarks = let
    home = config.home.homeDirectory;
  in [
    "file://${home}/Documents"
    "file://${home}/Music"
    "file://${home}/Pictures"
    "file://${home}/Videos"
    "file://${home}/Downloads"
    "file://${home}/Desktop"
    "file://${home}/Work"
    "file://${home}/.config Config"
    "file:///run/media/${username}/common"
    "file:///run/media/${username}/extra"
    "smb://192.168.1.110/daboyuan"
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
