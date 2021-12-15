# This is Debian 11, codenamed bullseye.
FROM bs4-buildenv-debian11

COPY mozconfig /mozilla-unified
ADD work/MacOSX10.12.sdk /osx-cross/MacOSX-SDKs/MacOSX10.12.sdk
RUN rustup target add x86_64-apple-darwin
