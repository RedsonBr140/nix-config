{ config, pkgs, ... }:

{
  imports = [
    ../modules/common/base.nix
    ../modules/desktop/hyprland_cfg.nix
    ../modules/desktop/ironbar.nix
  ];
  

  wayland.windowManager.hyprland.settings.input = {
        kb_layout = "br";
        kb_variant = "abnt2";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        follow_mouse = 1;
        sensitivity = 0;

        #touchpad = {
        #  natural_scroll = false;
        #};
      };

  home.packages = with pkgs; [
    pavucontrol
    spotify
    mpv
  ];

  programs.vscode = {
    enable = true;
  };

  home.stateVersion = "25.11";
}