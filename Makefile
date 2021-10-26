.PHONY : all help clean veryclean check source buildenv build artifacts purge

version_file=./version
version:=$(shell cat $(version_file))


docker=sudo docker

all : source build artifacts

help :
	@echo "use: make all help clean veryclean check build buildenv artifacts"
	@echo ""
	@echo "note: use 'make buildenv' to build the docker images locally."

clean :
	make -C source clean
	make -C build/debian10 clean
	make -C artifacts/debian10 clean

veryclean : # deliberately not depending on 'clean' in this case.
	make -C source veryclean
	make -C buildenv/debian10 veryclean
	make -C build/debian10 veryclean
	make -C artifacts/debian10 veryclean

#
# Keeping ./version up to date.
#

check :
	@python3 update-version.py

#
# Making the source tarball
#

source :
	make -C source all

#
# buildenv: Creating build environment and performing the build
#

buildenv :
	make -C buildenv/debian10 build

no-cache :
	make -C buildenv/debian10 no-cache

upload :
	make -C buildenv/debian10 upload

# zapping all docker state..
purge : prune
prune :
	$(docker) system prune --all --force


#
# build: Building the mozilla tree and artifact
#

build :
	make -C build/debian10 build

#
# artifacts
#

artifacts : 
	make -C artifacts/debian10 all

