.PHONY : all help clean veryclean check source buildenv build artifacts pub purge init

version_file=./version
version:=$(shell cat $(version_file))

include assets/Makefile.includes

help :
	@echo "use: make [all] [clean] [veryclean] [check]"
	@echo "          [source] [buildenv] [build] [artifacts] [pub]"
	@echo "          [purge] [prune] [init]"
	@echo ""
	@echo "  all         - make source build artifacts pub"
	@echo "  clean       - clean the biggest folders and intermediate results."
	@echo "  veryclean   - clean everything, including sources and artifacts."
	@echo "  check       - check if there is a new version of Firefox."
	@echo ""
	@echo "  source      - create the source tarball."
	@echo ""
	@echo "  build       - actually build the browser"
	@echo "  artifacts   - transform the build artifact to OS specific format."
	@echo "  pub         - copy the final artifact to the pub/librewolf tree."
	@echo ""
	@echo "  buildenv    - 'docker build' the images needed for building."
	@echo "  no-cache    - 'docker build --no-cache' the images."
	@echo "  upload      - upload the images to docker hub."
	@echo ""
	@echo "  purge/prune - remove all docker resources not currently in use."
	@echo "  init        - run bootstrap.py locally."

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
# The 'all' target builds everything while trying to minimize
# disk space.
#

all : source
	make debian10
	make -C artifacts/debian10 pub
	make -C build/debian10 veryclean # reclaim disk space

debian10 :
	make -C build/debian10 all # perform ./mach build && ./mach package
	make -C artifacts/debian10 all # make final artifacts


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


#
# zapping all docker state..
#

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


pub :
	make -C artifacts/debian10 pub


#
# init: run bootstrap on local machine
#

init :
	wget -q "https://hg.mozilla.org/mozilla-central/raw-file/default/python/mozboot/bin/bootstrap.py"
	python3 bootstrap.py --no-interactive --application-choice=browser
	rm -rf bootstrap.py mozilla-unified


