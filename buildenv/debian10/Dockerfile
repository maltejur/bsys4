# this is Debian 10, codenamed buster.
FROM debian:buster
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Amsterdam
RUN apt-get -y update && apt-get -y upgrade

# these are the dependencies needed to run 'mach bootstrap'
RUN apt-get -y install wget git python3 python3-pip python3-dev mercurial

RUN wget -q https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py
RUN (python3 bootstrap.py --no-interactive --application-choice=browser && rm -rf bootstrap.py)

# tools for 'make shell' in the build and artifact stages.
RUN apt-get -y install emacs-nox vim mc

# our work happens here, on the host filesystem.
RUN mkdir /work
WORKDIR /work
VOLUME ["/work"]
