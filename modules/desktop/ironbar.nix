{ config, pkgs, inputs, ... }:

{
    imports = [
        inputs.ironbar.homeManagerModules.default
    ]

    programs.ironbar = {
        enable = true;
        systemd = true;

        package = inputs.ironbar.packages.${pkgs.system}.default;

        config = {
      monitors = {
        eDP-1 = {
          anchor_to_edges = true;
          position = "top";
          height = 28;

          start = [
            { type = "workspaces"; }
          ];

          center = [
            { type = "focused"; }
          ];

          end = [
            {
              type = "tray";
              icon_size = 16;
            }
            {
              type = "clock";
              format = "%H:%M";
            }
          ];
        };
      };
    };

    style = ''
      * {
        font-family: "Noto Sans Nerd Font", sans-serif;
        font-size: 14px;
        border: none;
        border-radius: 0;
      }
    '';
    };
}