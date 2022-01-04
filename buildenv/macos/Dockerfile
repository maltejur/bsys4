FROM librewolf/bsys4-buildenv-debian11

RUN /root/.cargo/bin/rustup target add x86_64-apple-darwin

COPY mozconfig /mozilla-unified
ADD MacOSX11.3.sdk /osx-cross/MacOSX-SDKs/MacOSX11.3.sdk

RUN (cd /mozilla-unified && ./mach artifact toolchain --from-build linux64-libdmg)
RUN (cd /mozilla-unified && ./mach artifact toolchain --from-build linux64-cctools-port)
RUN (cd /mozilla-unified && ./mach artifact toolchain --from-build linux64-hfsplus)
RUN (cd /mozilla-unified && ./mach artifact toolchain --from-build linux64-binutils)
RUN (cd /mozilla-unified && ./mach artifact toolchain --from-build linux64-clang-macosx-cross)
RUN (cd /mozilla-unified ; ./mach build ; true)
#RUN (cd /mozilla-unified && ./mach package )
