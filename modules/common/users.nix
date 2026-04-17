{ pkgs, ... }:

{
    users.users.redson = {
      isNormalUser = true;
      description = "Redson";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
    };
}