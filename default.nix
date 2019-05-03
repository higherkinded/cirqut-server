{ mkDerivation, ghc, cabal-install, aeson, base, beam-core
, beam-postgres, beam-migrate, bytestring, case-insensitive
, comonad, directory, http-types, postgresql-libpq, openssl_1_1
, split, stdenv, text, time, wai, warp, uuid, zlib
}:
mkDerivation {
  pname = "cirqut-server";
  version = "0.0.1.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  libraryPkgconfigDepends = [ zlib ];
  executableHaskellDepends = [
    aeson
    base
    bytestring
    beam-core
    beam-postgres
    case-insensitive
    comonad
    directory
    http-types
    postgresql-libpq
    openssl_1_1
    split
    text
    time
    wai
    warp
    uuid
    zlib
  ];
  homepage = "https://github.com/higherkinded/cirqut-server";
  description = "A self-hosted multi-user project management tool";
  license = stdenv.lib.licenses.bsd3;
}
