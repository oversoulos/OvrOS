{ config, pkgs, lib, username, hostname, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core
    ../../modules/desktop
  ];

  networking.hostName = hostname;

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "podman" ];
    shell = pkgs.zsh;
  };

  # zsh is set as the user's shell above, so it must be enabled system-wide too
  programs.zsh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data were taken. Do NOT bump this casually
  # after initial install — see the NixOS manual.
  system.stateVersion = "24.11";
}
