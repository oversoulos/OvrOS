{ ... }:
{
  programs.git = {
    enable = true;
    # userName = "Your Name";       # <-- uncomment and fill in
    # userEmail = "you@example.com"; # <-- uncomment and fill in
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
