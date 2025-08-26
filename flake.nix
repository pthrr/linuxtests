{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    kernel = pkgs.linuxPackages_6_13.kernel;
  in {
    devShells.${system}.default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        ncurses
        kernel.dev
        elfutils
        glibc.dev
        glibc.static
        gcc14
        binutils
        flex
        bison
        bc
        kmod
        pahole

        clang_18
        lld_18
        llvm_18
        libbpf
        bpftools

        pkg-config
        openssl.dev

        go-task
      ];
      shellHook = ''
        export KDIR="${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
        export LLVM_SYS_180_PREFIX="${pkgs.llvm_18.dev}"
        export LIBCLANG_PATH="${pkgs.clang_18.cc.lib}/lib"
        echo "KDIR set to: $KDIR"
        echo "GCC version: $(gcc --version | head -1)"
        echo "Clang version: $(clang --version | head -1)"
      '';
    };
  };
}
