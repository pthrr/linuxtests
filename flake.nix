{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    kernel = pkgs.linuxPackages_6_12.kernel;
  in {
    devShells.${system}.default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        ncurses
        kernel.dev
        elfutils
      ];

      shellHook = ''
        export KDIR="${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
        echo "KDIR set to: $KDIR"
      '';
    };
  };
}
