{ pkgs, username, ... }:
{
  imports = [
    ./modules/shell.nix
    ./modules/git.nix
    ./modules/ghostty.nix
    ./modules/neovim.nix
    ./modules/yazi.nix
    ./modules/podman.nix
    ./modules/hyprland-user.nix
    ./theme.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
