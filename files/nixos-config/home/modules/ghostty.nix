{ pkgs, ... }:
{
  # If your home-manager channel doesn't yet ship `programs.ghostty`,
  # comment this block out and use `home.packages = [ pkgs.ghostty ];`
  # instead, then configure via ~/.config/ghostty/config directly.
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font";
      theme = "catppuccin-mocha";
      window-padding-x = 8;
      window-padding-y = 8;
    };
  };
}
