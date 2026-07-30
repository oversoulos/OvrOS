# Modular NixOS + Hyprland starter

Atomic, single-purpose modules wired together through `default.nix`
files at each layer. Nothing in here tries to be your whole system —
it gets you **installed, booted into Hyprland, and comfortable at a
terminal**. Everything else (dev tooling, compose stacks, extra
packages, real dotfiles) gets added from *inside*, one module at a
time, using this same pattern.

## The pattern (repeat this forever)

Every module is a plain file that returns a NixOS or home-manager
module: `{ config, pkgs, lib, ... }: { ...settings... }`. To add a
capability:

1. Create `modules/core/thing.nix` (system-wide) or
   `home/modules/thing.nix` (your user only).
2. Add `./thing.nix` to the relevant `default.nix` imports list.
3. `sudo nixos-rebuild switch --flake .#default`

That's the whole loop. Same shape every time — that's the
"fractal/reusable" property you were after. A module can be as small
as three lines or as big as a whole dev-environment definition; the
import mechanism doesn't care.

## Directory tree

```
flake.nix                          entry point — system/hostname/username live here
hosts/default/
  configuration.nix                host-specific glue, defines the user
  hardware-configuration.nix        PLACEHOLDER — replace with your generated one
modules/core/                       system-wide essentials (host-agnostic)
  boot.nix                          bootloader + kernel
  networking.nix                    NetworkManager + firewall
  locale.nix                        timezone + locale
  nix-settings.nix                  flakes, gc, unfree
  fonts.nix                         nerd font + emoji + CJK coverage
  containers.nix                    podman daemon (docker-compatible)
modules/desktop/                    Hyprland + supporting system services
  hyprland.nix                      compositor enable + portals
  audio.nix                         pipewire
  greeter.nix                       greetd/tuigreet -> straight into Hyprland
home/                               your user layer (home-manager)
  default.nix                       aggregator + home.username/homeDirectory
  theme.nix                         gtk/icon/cursor theme
  modules/
    shell.nix                       zsh + starship
    git.nix                         git identity (fill in name/email)
    ghostty.nix                     terminal
    neovim.nix                      bare enable, config comes later
    yazi.nix                        file manager
    podman.nix                      podman-compose / podman-tui CLI
    hyprland-user.nix               keybinds, waybar, wofi launcher
```

## Before you install — checklist

- [ ] Edit `flake.nix`: set `system`, `hostname`, `username`
- [ ] Edit `hosts/default/configuration.nix`: matches the username above
- [ ] Edit `modules/core/locale.nix`: your timezone
- [ ] (optional) Edit `home/modules/git.nix`: your name/email
- [ ] Rename `hosts/default/` to your actual hostname if you're not
      keeping it literally called `default` (and update `flake.nix`
      + `configuration.nix`'s `hostname` accordingly)
- [ ] Have a NixOS live ISO ready, disks already partitioned/mounted
      at `/mnt` your way (this repo doesn't assume disko or any
      particular partition scheme — you said you know your hardware)

## Install steps

From the live ISO, after partitioning and mounting to `/mnt`:

```sh
# generate the REAL hardware config for this machine
nixos-generate-config --root /mnt

# get this repo onto the target (git clone, curl, scp — however)
# then copy the generated hardware file in, overwriting the placeholder:
cp /mnt/etc/nixos/hardware-configuration.nix \
   /path/to/nixos-config/hosts/default/hardware-configuration.nix

cd /path/to/nixos-config

# install using this flake
nixos-install --flake .#default

reboot
```

On first boot you land at the tuigreet prompt, log in, and Hyprland
starts. `SUPER+Return` opens ghostty, `SUPER+E` opens yazi, `SUPER+R`
opens the app launcher.

## After you're in

- `rebuild` is aliased to `sudo nixos-rebuild switch --flake .#default`
  from anywhere — but you'll want to `cd` into wherever you keep this
  repo (consider putting it in `~/nixos-config` and treating it as a
  normal git repo from here on).
- Add packages: quick experiments go in `home.packages` inside
  whichever module they belong to (or a new `home/modules/extras.nix`
  if they don't belong anywhere yet).
- Dev environments: this intentionally does *not* prescribe devenv
  vs. plain `nix develop` vs. per-project flakes — that's a "many
  small reusable modules" decision better made once you're inside
  and can feel out which project shapes you actually have. A natural
  next module: `home/modules/dev-shells.nix` or a `flakes/` directory
  of per-language templates you `nix flake init -t` from.
- Container compose stacks: `podman-compose` is installed; a natural
  next module is `modules/core/containers.nix` gaining a
  `virtualisation.oci-containers` block, or keeping compose files in
  a `containers/` directory you manage by hand — both are one-file
  additions.
- Multimedia/creative tools: add as their own
  `home/modules/multimedia.nix` when you know what you actually want
  installed, rather than guessing now.

## Notes / things that may need adjusting

- `programs.ghostty` in home-manager is relatively new — if your
  pinned home-manager revision doesn't have it yet, the module has a
  fallback comment explaining the swap to `home.packages`.
- `wofi` is used as the launcher for simplicity; swap for `rofi` or
  `fuzzel` freely, it's a one-line change in
  `home/modules/hyprland-user.nix`.
- No disk partitioning tool (disko, etc.) is included on purpose —
  you said you're comfortable handling that manually.
