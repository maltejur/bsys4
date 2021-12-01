# This is Debian 11, codenamed bullseye.
FROM debian:bullseye
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Amsterdam
RUN apt-get -y update && apt-get -y upgrade

# these are the dependencies needed to run 'mach bootstrap'
RUN apt-get -y install wget git python3 python3-pip python3-dev mercurial

# tools for 'make shell' in the build and artifact stages.
RUN apt-get -y install emacs-nox vim mc

# The main task: copy the mozilla source in, and bootstrap.
#ADD mozilla-unified /mozilla-unified
# We no longer ADD (it takes way too long). we bind mount instead.
#WORKDIR /mozilla-unified
#RUN (./mach bootstrap --application-choice=browser ; true)

COPY build-deb-buildenv.sh /

# our work happens here, on the host filesystem.
RUN mkdir /work
WORKDIR /work
VOLUME ["/work"]
