{
  description = "A declarative NixOS system configuration using Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    hostname = "nixos";
    system = "x86_64-linux";
    stateVersion = "25.11";

    username = "tau";
    passwordHash = "DUMMY_HASH_REPLACE_DURING_INSTALL";

    gitUsername = "tautastic";
    gitUseremail = "tautastic@proton.me";
  in
  {
    nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
      system = system;

      specialArgs = {
        inherit hostname system stateVersion username passwordHash gitUsername gitUseremail;
      };

      modules = [
        { system.stateVersion = stateVersion; }
        home-manager.nixosModules.home-manager
        ./sub/home-manager/home.nix
        ./sub/docker.nix
        ./sub/user.nix
        ./sub/hardware-configuration.nix
        ./sub/boot.nix
        ./sub/ssh.nix
        ./sub/gnome-desktop.nix
        ./sub/system-packages.nix
        ./sub/system-settings.nix
      ];
    };
  };
}
