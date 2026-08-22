{ ... }: {
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "huon"
    ];
    extra-substituters = [
      "https://ros.cachix.org"
      "https://roar.cachix.org"
    ];
    extra-trusted-substituters = [
      "https://ros.cachix.org"
      "https://roar.cachix.org"
    ];
    extra-trusted-public-keys = [
      "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo="
      "roar.cachix.org-1:XYRwk2AeKATRiicsHxRkk3VWIaitbG6saW5YZvIaPec="
    ];
    warn-dirty = false; # disable the git tree dirty warning when using flakes
  };
}
