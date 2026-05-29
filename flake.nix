{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    # TODO: darwin support
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" "loongarch64-linux" ] (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        classisland = pkgs.callPackage ./tools/nix/classisland.nix {
          soundflow-miniaudio = pkgs.callPackage ./tools/nix/soundflow-miniaudio.nix { };
        };
        classisland-bin = pkgs.callPackage ./tools/nix/classisland-bin.nix { };
      in
      {
        packages =
          if system != "loongarch64-linux" then
            {
              inherit classisland classisland-bin;
              default = classisland-bin;
            }
          else
            {
              inherit classisland;
              default = classisland;
            };
      }
    );
}
