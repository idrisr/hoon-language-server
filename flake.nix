{
  description = "LSP bridge for Hoon";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system} = rec {
        hoon-language-server = pkgs.callPackage ./. { };
        default = hoon-language-server;
      };
      apps.${system}.default = {
        type = "app";
        program = "${
            self.packages.${system}.hoon-language-server
          }/bin/hoon-language-server";
      };
      overays = {
        hoon-language-server = final: prev: {
          inherit (self.packages) hoon-language-server;
        };
      };
    };
}
