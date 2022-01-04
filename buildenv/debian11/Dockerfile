# This is Debian 11, codenamed bullseye.


FROM debian:bullseye AS stage1
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Amsterdam
RUN apt-get -y update && apt-get -y upgrade

# these are the dependencies needed to run 'mach bootstrap'
RUN apt-get -y install wget git python3 python3-pip python3-dev mercurial

# this is the space-intensive part. (ADD /huge ; ... ; RUN rm -rf /huge)
COPY buildenv.sh /
ADD mozilla-unified /mozilla-unified
RUN bash buildenv.sh


FROM debian:bullseye AS stage2
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Amsterdam
RUN apt-get -y update && apt-get -y upgrade

# these are the dependencies needed to run 'mach bootstrap'
RUN apt-get -y install wget git python3 python3-pip python3-dev mercurial

# Take the MOZBUILD (/root/.mozbuild)  folder from stage1
COPY --from=stage1 /root /root

# our work happens here, on the host filesystem.
RUN mkdir /work
WORKDIR /work
VOLUME ["/work"]
