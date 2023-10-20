{
  description = "Ansible playbooks and roles for deploying a reference platform cluster";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.05";
    flake-utils.url = "github:numtide/flake-utils/v1.0.0";
    mach-nix = {
      url = "github:DavHau/mach-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs = { self, nixpkgs, flake-utils, mach-nix, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        python-packages = mach-nix.lib."${system}".mkPython {
          requirements = builtins.readFile ./requirements.txt;
        };
      in {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          ansible
          k9s
          kubectl
          kubernetes-helm
          kubernetes-helmPlugins.helm-diff # Ansible module kubernetes.core.helm reports this improves change detection
          libiconv # Needed for ripsecrets pre-commit
          pre-commit
        ] ++ [ python-packages ];
      };
    });
}
