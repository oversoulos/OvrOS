# PLACEHOLDER — DO NOT INSTALL WITH THIS FILE AS-IS.
#
# Boot the NixOS live ISO, partition/mount your disks, then run:
#
#     nixos-generate-config --root /mnt
#
# This generates a REAL hardware-configuration.nix at
# /mnt/etc/nixos/hardware-configuration.nix containing your actual
# filesystems, UUIDs, kernel modules, and CPU microcode settings.
# Copy that file over this one before running nixos-install.
#
# It is intentionally left out of this repo because it is unique to
# each physical machine and regenerating it wrong will break boot.

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # Everything below is a stand-in so the flake evaluates before you
  # swap in the real file. Replace this whole file.
  boot.initrd.availableKernelModules = [ ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
