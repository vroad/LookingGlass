let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};
  nixcrpkgs = import sources.nixcrpkgs {};
  gcc = nixcrpkgs.x86_64-w64-mingw32.gcc;
  binutils = nixcrpkgs.x86_64-w64-mingw32.binutils;
in
pkgs.stdenv.mkDerivation
{
  name = "custom-gcc";
  version = gcc.version;

  phases = ["installPhase"];

  installPhase = ''
    set -x
    ln -s ${gcc}/bin/gcc $out/x86_64-w64-mingw32-gcc
    ln -s ${gcc}/bin/g++ $out/x86_64-w64-mingw32-g++
    ln -s ${binutils}/bin/windres $out/x86_64-w64-mingw32-windress
  '';
}
