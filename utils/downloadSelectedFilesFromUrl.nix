{ pkgs, baseUrl, paths }:
map (p:
  pkgs.fetchurl {
    url = baseUrl + p.path;
    sha256 = p.sha256;
    passthru = { name = p.path; };
  }) paths
