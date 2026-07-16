{ ... }: {
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.trusted-users = [
    "huon"
    "@wheel"
  ];
  nix.settings.trusted-substituters = [
    "https://roar-qutrc.cachix.org"
    "https://ros.cachix.org"
  ];
  nix.settings.extra-trusted-public-keys = [
    "roar-qutrc.cachix.org-1:ZKgHZSSHH2hOAN7+83gv1gkraXze5LSEzdocPAEBNnA="
    "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo="
  ];
}
