{ ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -la";
      rebuild = "sudo nixos-rebuild switch --flake .#default";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
