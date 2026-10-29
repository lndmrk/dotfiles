# SPDX-FileCopyrightText: 2026 Emil Lundmark <emil@lndmrk.se>
# SPDX-License-Identifier: GPL-3.0-or-later

{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.git-hooks.flakeModule ];

      systems = [ "x86_64-linux" ];

      perSystem = { config, pkgs, ... }: {
        pre-commit.settings = {
          src = ./.;
          hooks = {
            deadnix.enable = true;
            mdformat.enable = true;
            nixfmt.enable = true;
            reuse.enable = true;
            statix.enable = true;
          };
        };

        devShells.default = pkgs.mkShell {
          inputsFrom = [ config.pre-commit.devShell ];
          packages = with pkgs; [ nixd ];
        };
      };
    };
}
