FROM linuxmintd/mint20.2-amd64
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Amsterdam
RUN apt-get -y update && apt-get -y upgrade

# Install build dependencies..
run apt-get -y install wget git python3 python3-pip python3-dev mercurial

# Fetch mozilla nightly..
RUN wget -q https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py
RUN (python3 bootstrap.py --no-interactive --application-choice=browser && rm -f bootstrap.py)

RUN apt-get -y install emacs-nox vim mc

RUN mkdir /work
WORKDIR /work
VOLUME ["/work"]
