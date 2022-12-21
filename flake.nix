{
  description = "Embedded Controller tool for the Framework Laptop";

  inputs.nixpkgs.url = "nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    {
      overlays.default =
        (
          final: prev: {
            fw-ectool = prev.callPackage ./default.nix { pkgs = prev; };
          }
        );
    } // (
      flake-utils.lib.eachDefaultSystem (system:
        let
          pkgs = import nixpkgs { inherit system; overlays = [ self.overlays.default ]; };
        in
        {
          packages = {
            fw-ectool = pkgs.fw-ectool;
          };
        }));
}
