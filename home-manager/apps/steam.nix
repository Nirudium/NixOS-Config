{pkgs, inputs, ...}:
{
  programs.steam = {
    # enable steam as usual
    enable = true;

    extraCompatPackages = [
      inputs.nix-gaming.packages.${pkgs.system}.proton-ge
    ];
  };
}
