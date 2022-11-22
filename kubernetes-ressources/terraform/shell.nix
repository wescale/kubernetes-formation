{ sources ? import ./nix/sources.nix }:
let nixpkgs =  import sources.nixpkgs {};
in nixpkgs.runCommand "deps" {
  buildInputs = [
    nixpkgs.google-cloud-sdk
    nixpkgs.terraform
  ];
} ""
