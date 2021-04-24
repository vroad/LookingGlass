let
  sources = import ./nix/sources.nix {};
  nixcrpkgs = import sources.nixcrpkgs {};
  crossenv = nixcrpkgs.win64;
in
crossenv.make_derivation rec {
  name = "looking-glass-host";
  src = ./.;
  builder = ./builder.sh;
}
