{
  description = "NixOS Configuration flake to manage all of my machines";

  inputs = {
    # NixOS official package source, using the nixos-25.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
  let mkHost = { name, system, realHostname, homeModule }: nixpkgs.lib.nixosSystem {
    inherit system;

    specialArgs = { inherit inputs self; };

    modules = [
      ./hosts/${name}
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
