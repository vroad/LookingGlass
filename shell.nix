let
  sources = import ./nix/sources.nix;
  nixpkgs = sources.nixpkgs;
  pkgs = import nixpkgs {};
  kernel = pkgs.linuxPackages_5_10.kernel;
in
pkgs.mkShell {
  # nativeBuildInputs = with pkgs; [ cmake pkg-config ];
  # NIX_CFLAGS_COMPILE = "-mavx -Wno-uninitialized";
  # NIX_HARDENING_ENABLE = "";
  buildInputs = with pkgs; [
    gcc
    binutils
    # SDL2 SDL2_ttf spice-protocol fontconfig libX11 freefont_ttf nettle
    # libXau libXdmcp libXi libXext wayland libffi libbfd expat
    # libXScrnSaver wayland-protocols
  ];
  makeFlags = with kernel; [
    "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];
  hardeningDisable = [ "pic" "format" ];
  nativeBuildInputs = kernel.moduleBuildDependencies;
}
