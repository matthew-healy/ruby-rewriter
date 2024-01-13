{

  description = "An untitled programming language project.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils, pre-commit-hooks }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        preCommitHook = pre-commit-hooks.lib.${system}.run {
          src = self;
          hooks = {
            nixpkgs-fmt.enable = true;
            rustfmt.enable = true;
          };
        };
      in
      {
        devShells.default = pkgs.mkShell {
          LIBCLANG_PATH = "${pkgs.llvmPackages_11.libclang.lib}/lib";

          shellHook = ''
            ${preCommitHook.shellHook}
          '';

          nativeBuildInputs = with pkgs; [
            clang
            rustc
            rustfmt
            cargo
            clippy
            rust-analyzer
            nixpkgs-fmt
          ];
        };

        checks = {
          pre-commit = preCommitHook;
        };
      }
    );
}
