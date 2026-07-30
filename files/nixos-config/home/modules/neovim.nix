{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    # extraConfig / plugins go here once you're in and ready to build
    # your own setup, or point this at a cloned LazyVim-style starter.
  };
}
