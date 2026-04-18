{
  description = "NixOS Configuration flake to manage all of my machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    ironbar = {
    url = "github:JakeStanger/ironbar";
    inputs.nixpkgs.follows = "nixpkgs";
  };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ironbar, ... }:
  let mkHost = { name, system, realHostname, homeModule }: nixpkgs.lib.nixosSystem {
    inherit system;

    specialArgs = { inherit inputs self; };

    modules = [
      ./hosts/${name}
      ({ ... }: {
        nixpkgs.overlays = [
            (import ./overlays/spotify-adblock.nix)
        ];
      })
      {
        networking.hostName = realHostname;
      }

      home-manager.nixosModules.default {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.redson = import homeModule;
          extraSpecialArgs = { inherit inputs; };
        };
      }
    ];
  };
  in
   {
    nixosConfigurations = {
      work = mkHost {
        name = "work";
        system = "x86_64-linux";
        realHostname = "ntl-wks-0102-linux";
        homeModule = ./home/redson/profiles/workstation.nix;
      };
      laptop = mkHost {
        name = "laptop";
        system = "x86_64-linux";
        realHostname = "r2d2";
        # FIXME: Should begin using the real profile.
        homeModule = ./home/redson/profiles/workstation.nix;
      };
    };
   };
}
