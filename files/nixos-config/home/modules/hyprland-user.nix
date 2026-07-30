{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",preferred,auto,1";

      "$terminal" = "ghostty";
      "$fileManager" = "ghostty -e yazi";
      "$menu" = "wofi --show drun";

      exec-once = [
        "waybar"
      ];

      bind = [
        "SUPER, Return, exec, $terminal"
        "SUPER, Q, killactive"
        "SUPER, E, exec, $fileManager"
        "SUPER, R, exec, $menu"
        "SUPER, M, exit"
        "SUPER, V, togglefloating"
        "SUPER, F, fullscreen"
      ];

      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
      };
    };
  };

  programs.waybar.enable = true;

  home.packages = with pkgs; [
    wofi
  ];
}
