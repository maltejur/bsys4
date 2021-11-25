FROM fedora:35
RUN dnf -y update

# locale stuff, see: https://superuser.com/questions/959380/how-do-i-install-generate-all-locales-on-fedora
RUN echo "%_install_langs C:en:en_US:en_US.UTF-8" > /etc/rpm/macros.image-language-conf
RUN dnf -y reinstall glibc-common

# Install build dependencies..
run dnf -y install wget python3 python3-pip python3-devel mercurial


RUN wget -q https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py
RUN (python3 bootstrap.py --no-interactive --application-choice=browser ; rm -rf bootstrap.py mozilla-unified)

RUN dnf -y install emacs vim mc

# added this stuff to try make it work, somehow this was
# not needed with debian based distro's
RUN dnf -y install rustc cargo cbindgen clang

# install rpm tools
RUN dnf -y install rpm-build


RUN mkdir /work
WORKDIR /work
VOLUME ["/work"]
