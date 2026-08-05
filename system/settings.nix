{ ... }: {
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "huon"
    ];
    trusted-substituters = [
      "https://roar-qutrc.cachix.org"
      "https://ros.cachix.org"
      "https://rover-test.cachix.org"
    ];
    extra-trusted-public-keys = [
      "roar-qutrc.cachix.org-1:ZKgHZSSHH2hOAN7+83gv1gkraXze5LSEzdocPAEBNnA="
      "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo="
      "rover-test.cachix.org-1:oKrjMSfZYXuiMmBhQmD8xPRxLj/6VX+pPOYzAR5Ld9k="
    ];
    warn-dirty = false; # disable the git tree dirty warning when using flakes
  };
}
