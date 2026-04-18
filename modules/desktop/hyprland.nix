{ pkgs, ... }:

{
  services.displayManager.ly.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL= "1";
}