{config, pkgs, ...}: {
  # nix
  documentation.nixos.enable = false; # .desktop
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  time.hardwareClockInLocalTime = true;

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
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # packages
  environment.systemPackages = with pkgs; [
    home-manager
    neovim
    git
    wget
    man-pages 
    man-pages-posix
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
      device = "/dev/disk/by-uuid/3FEE24F8E3EC9143";
      fsType = "ntfs-3g";
      options = ["rw" "uid=${toString config.users.users.fu1lp0w3r.uid}"];
  };

  fileSystems."/run/media/fu1lp0w3r/extra" = {
      device = "/dev/disk/by-uuid/65F33762C14D581B";
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
    kernelPackages = pkgs.linuxPackages_latest;
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
