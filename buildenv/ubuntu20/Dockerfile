FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Amsterdam
RUN apt-get -y update && apt-get -y upgrade

# these are the dependencies needed to run 'mach bootstrap'
RUN apt-get -y install wget git python3 python3-pip python3-dev mercurial

# tools for 'make shell' in the build and artifact stages.
RUN apt-get -y install emacs-nox vim mc

COPY buildenv.sh /
ADD mozilla-unified /mozilla-unified
RUN bash buildenv.sh

# our work happens here, on the host filesystem.
RUN mkdir /work
WORKDIR /work
VOLUME ["/work"]
