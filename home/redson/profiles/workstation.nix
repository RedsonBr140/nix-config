{ config, pkgs, ... }:

{
  home.username = "redson";
  home.homeDirectory = "/home/redson";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    pavucontrol
    mpv
  ];

  programs.git = {
    enable = true;
    userName = "Redson";
    userEmail = "redson@riseup.net";
    signing = {
      key = "A55CD2880240ABD7";
      signByDefault = true;
    };
  };

  programs.vscode = {
    enable = true;
  };

  home.stateVersion = "25.11";
}