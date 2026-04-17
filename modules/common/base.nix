{pkgs, ...}:

{
    boot.loader.grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
    };

    boot.loader.efi.canTouchEfiVariables = true;

    # Enable networking
    networking.networkmanager.enable = true;

    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [ "nix-command" "flakes"];

    # Docker my boy
    virtualisation.docker = {
        enable = true;
    };

    environment.systemPackages = with pkgs; [
      vim
      wget
  ];
}