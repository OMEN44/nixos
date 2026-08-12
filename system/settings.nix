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
      "https://roar.cachix.org"
      "https://ros.cachix.org"
    ];
    extra-trusted-public-keys = [
      "roar.cachix.org-1:XYRwk2AeKATRiicsHxRkk3VWIaitbG6saW5YZvIaPec="
      "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo="
    ];
    warn-dirty = false; # disable the git tree dirty warning when using flakes
  };
}
