{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./qbitorrent_module.nix
    ./tdarr.nix
    ./debrid.nix
    ./dedupe.nix
  ];
  users.users."qbittorrent" = {
    isSystemUser = true;
    group = "media";
  };

  users.groups.media = {
    members = [
      "jellyfin"
      "qbittorrent"
      "radarr"
      "sonarr"
      "prowlarr"
      "jellyseerr"
    ];
    gid = 1666;
  };
  users.groups.media = {};
  environment.systemPackages = with pkgs; [
    jellyfin-web
    jellyfin-ffmpeg
    jellyfin-media-player
    jdupes
    ncdu
    rclone
  ];

  networking.firewall.allowedTCPPorts = [5690];
  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers."wizarr" = {
    autoStart = true;
    image = "ghcr.io/wizarrrr/wizarr:latest";
    ports = ["5690:5690"];
    volumes = ["/home/noor/wizarr:/data/database"];
  };

  services = rec {
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    radarr = jellyfin;
    prowlarr = jellyfin;
    sonarr = radarr;
    jellyseerr = jellyfin;
    qbittorrent = lib.mkMerge [
      jellyfin
      {
        group = "media";
        dataDir = "/mnt/nuclearmissilesilo/qbittorrent_dls";
        port = 5080;
      }
    ];
  };
}
