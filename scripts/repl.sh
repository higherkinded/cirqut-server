#!/bin/sh
ZLIB="$(nix-build --no-out-link '<nixpkgs>' -A zlib)"
echo "zlib: ${ZLIB}"
#
# Uncomment if you've broken your 'cabal v2-repl' via Dante
#
# (and if you're using Dante, you'd probably like to run
#  the REPL inside a Nix shell first)
#    __     __     __     __     __     __     __     __
#    ||     ||     ||     ||     ||     ||     ||     ||
#   _||_   _||_   _||_   _||_   _||_   _||_   _||_   _||_
#   \  /   \  /   \  /   \  /   \  /   \  /   \  /   \  /
#    \/     \/     \/     \/     \/     \/     \/     \/
#
# cabal v2-repl --builddir=dist/dante --extra-lib-dirs=${ZLIB}/lib -j7
#
cabal v1-repl --builddir=dist/dante
