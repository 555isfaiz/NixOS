{
  description = "Configurations of fu1lp0w3r";

  outputs = inputs @ {
    self,
    home-manager,
    nixpkgs,
    ...
  }: {
    packages.x86_64-linux.default =
      nixpkgs.legacyPackages.x86_64-linux.callPackage ./ags {inherit inputs;};

    # nixos config
    nixosConfigurations = {
      "FU1LP0W3R0NN1X" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          asztal = self.packages.x86_64-linux.default;
        };
        modules = [
          ./nixos.nix
          home-manager.nixosModules.home-manager
          {networking.hostName = "FU1LP0W3R0NN1X";}
        ];
      };
    };

    # macos hm config
    #homeConfigurations = {
    #  "demeter" = home-manager.lib.homeManagerConfiguration {
    #    pkgs = nixpkgs.legacyPackages.x86_64-darwin;
    #    extraSpecialArgs = {inherit inputs;};
    #    modules = [
    #      ({pkgs, ...}: {
    #        nix.package = pkgs.nix;
    #        home.username = "demeter";
    #        home.homeDirectory = "/Users/demeter";
    #        imports = [./macos/home.nix];
    #      })
    #    ];
    #  };
    #};
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprland-hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };

    matugen.url = "github:InioX/matugen?ref=v2.2.0";
    ags.url = "github:Aylur/ags";
    astal.url = "github:Aylur/astal";

    lf-icons = {
      url = "github:gokcehan/lf";
      flake = false;
    };

    firefox-gnome-theme = {
      url = "github:Naezr/ShyFox";
      flake = false;
    };
  };
}
