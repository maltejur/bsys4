FROM fedora:34
RUN dnf -y update

# locale stuff, see: https://superuser.com/questions/959380/how-do-i-install-generate-all-locales-on-fedora
RUN echo "%_install_langs C:en:en_US:en_US.UTF-8" > /etc/rpm/macros.image-language-conf
RUN dnf -y reinstall glibc-common

# Install build dependencies.
RUN dnf -y install wget python3 python3-pip python3-devel mercurial
RUN dnf -y install rpm-build # Install rpm tools for artifact stage.

# tools for 'make shell' in the build and artifact stages.
RUN dnf -y install emacs vim mc

COPY buildenv.sh /
ADD mozilla-unified /mozilla-unified
RUN bash buildenv.sh

# our work happens here, on the host filesystem.
RUN mkdir /work
WORKDIR /work
VOLUME ["/work"]
