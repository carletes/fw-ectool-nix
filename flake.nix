{
  description = "Embedded Controller coomand-line tool for the Framework Laptop";

  inputs.nixpkgs.url = "nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    {
      overlays.default =
        (
          final: prev: {
            framework-ectool = prev.callPackage ./default.nix { pkgs = prev; };
          }
        );
    } // (
      flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
        let
          pkgs = import nixpkgs { inherit system; overlays = [ self.overlays.default ]; };
        in
        {
          packages = {
            framework-ectool = pkgs.framework-ectool;
          };
        })
    );
}
