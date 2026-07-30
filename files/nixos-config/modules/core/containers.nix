{ ... }:
{
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # lets you run `docker` commands against podman
    defaultNetwork.settings.dns_enabled = true;
  };
}
