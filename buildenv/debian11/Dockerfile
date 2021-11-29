# This is Debian 11, codenamed bullseye.
FROM debian:bullseye
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Amsterdam
RUN apt-get -y update && apt-get -y upgrade

RUN apt-get -y install wget git python3 python3-pip python3-dev mercurial

RUN wget -q https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py
RUN (python3 bootstrap.py --no-interactive --application-choice=browser && rm -rf bootstrap.py)

RUN apt-get -y install emacs-nox vim mc

# this might fix our nodejs issue
#WORKDIR mozilla-unified
#RUN ./mach artifact toolchain --from-build osx-clang-12
#WORKDIR ..

# for cross-compile macos
RUN rustup target add aarch64-apple-darwin
RUN rustup target add x86_64-apple-darwin

RUN mkdir /work
WORKDIR /work
VOLUME ["/work"]
