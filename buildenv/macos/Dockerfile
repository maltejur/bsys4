FROM bs4-buildenv-debian11

RUN /root/.cargo/bin/rustup target add x86_64-apple-darwin

COPY mozconfig /mozilla-unified
ADD MacOSX10.12.sdk /osx-cross/MacOSX-SDKs/MacOSX10.12.sdk

RUN (cd /mozilla-unified && ./mach artifact toolchain --from-build linux64-libdmg)
RUN (cd /mozilla-unified && ./mach artifact toolchain --from-build linux64-cctools-port)
RUN (cd /mozilla-unified && ./mach artifact toolchain --from-build linux64-hfsplus)
RUN (cd /mozilla-unified && ./mach artifact toolchain --from-build linux64-binutils)
RUN (cd /mozilla-unified && ./mach artifact toolchain --from-build linux64-clang-macosx-cross)
RUN (cd /mozilla-unified && ./mach build )
