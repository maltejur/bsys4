#!/bin/sh
set -e
cd librewolf-*
#./mach artifact toolchain --from-build osx-clang-12
./mach build
./mach package
