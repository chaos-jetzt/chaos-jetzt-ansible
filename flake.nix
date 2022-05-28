{
  inputs = {
    nixpkgs.url="github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }@inputs:
  flake-utils.lib.eachDefaultSystem (system:
  let pkgs = import nixpkgs { inherit system; };
  in {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        ansible
        ansible-lint
      ];
      PASSWORD_STORE_DIR="~/.password-store/chaos/jetzt";
    };
  });
}
