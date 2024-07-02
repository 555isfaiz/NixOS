{config, pkgs, ...}: {
  # nix
  documentation.nixos.enable = false; # .desktop
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  # camera
  # programs.droidcam.enable = true;

  # virtualisation
  # programs.virt-manager.enable = true;
  virtualisation = {
    # podman.enable = true;
    docker.enable = true;
    # libvirtd.enable = true;
  };

  # dconf
  programs.dconf.enable = true;

  # packages
  environment.systemPackages = with pkgs; [
    home-manager
    neovim
    git
    wget
  ];

  # services
  services = {
    xserver = {
      enable = true;
      excludePackages = [pkgs.xterm];
    };
    printing.enable = true;
    flatpak.enable = true;
  };

  # logind
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=suspend
    HandleLidSwitchExternalPower=ignore
  '';

  # kde connect
  # networking.firewall = rec {
  #   allowedTCPPortRanges = [
  #     {
  #       from = 1714;
  #       to = 1764;
  #     }
  #   ];
  #   allowedUDPPortRanges = allowedTCPPortRanges;
  # };

  # windows disks
  fileSystems."/run/media/fu1lp0w3r/common" = {
      device = "/dev/nvme0n1p7";
      fsType = "ntfs-3g";
      options = ["rw" "uid=${toString config.users.users.fu1lp0w3r.uid}"];
  };

  fileSystems."/run/media/fu1lp0w3r/extra" = {
      device = "/dev/sda1";
      fsType = "ntfs-3g";
      options = ["rw" "uid=${toString config.users.users.fu1lp0w3r.uid}"];
  };

  # network
  # networking.networkmanager.enable = true;
  networking.hostName = "FU1LP0W3R0NN1X";

  # bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Experimental = true; # for gnome-bluetooth percentage
  };

  # bootloader
  boot = {
    tmp.cleanOnBoot = true;
    supportedFilesystems = ["ntfs"];
    loader = {
      timeout = 2;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  system.stateVersion = "24.05";
}
