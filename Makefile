.PHONY : all help clean veryclean check source buildenv build artifacts pub purge init

version_file=./version
version:=$(shell cat $(version_file))

include scripts/Makefile.includes


help :
	@echo "use: make [all] [clean] [veryclean] [check]"
	@echo "          [source] [pub] [buildenv] [no-cache]"
	@echo "          [purge] [prune] [init]"
	@echo ""
	@echo "  all         - do: make source [build-all] artifacts pub"
	@echo "  clean       - clean the biggest folders and intermediate results."
	@echo "  veryclean   - clean everything, including sources and artifacts."
	@echo "  check       - check if there is a new version of Firefox."
	@echo ""
	@echo "  source      - create the source tarball. ( WGET source tarball )"
	@echo ""
	@echo "  debian11    - build the browser for Debian 11."
	@echo "  mint20      - build the browser for Mint 20."
	@echo "  ubuntu20    - build the browser for Ubuntu 20."
	@echo "  fedora34    - build the browser for Fedora 34."
	@echo "  fedora35    - build the browser for Fedora 35."
	@echo ""
	@echo "  pub         - copy the final artifacts to the pub/librewolf tree."
	@echo ""
	@echo "  buildenv    - 'docker build' the images needed for building."
	@echo "  no-cache    - 'docker build --no-cache' the images."
	@echo ""
	@echo "  purge/prune - remove all docker resources not currently in use."
	@echo "  init        - run bootstrap.py locally."


clean :

	make -C source clean

	make -C buildenv/debian11 clean
	make -C build/debian11 clean
	make -C artifacts/debian11 clean

	make -C buildenv/mint20 clean
	make -C build/mint20 clean
	make -C artifacts/mint20 clean

	make -C buildenv/ubuntu20 clean
	make -C build/ubuntu20 clean
	make -C artifacts/ubuntu20 clean

	make -C buildenv/fedora34 clean
	make -C build/fedora34 clean
	make -C artifacts/fedora34 clean

	make -C buildenv/fedora35 clean
	make -C build/fedora35 clean
	make -C artifacts/fedora35 clean


veryclean : # deliberately not depending on 'clean' in this case.

	make -C source veryclean

	make -C buildenv/debian11 veryclean
	make -C build/debian11 veryclean
	make -C artifacts/debian11 veryclean

	make -C buildenv/mint20 veryclean
	make -C build/mint20 veryclean
	make -C artifacts/mint20 veryclean

	make -C buildenv/ubuntu20 veryclean
	make -C build/ubuntu20 veryclean
	make -C artifacts/ubuntu20 veryclean

	make -C buildenv/fedora34 veryclean
	make -C build/fedora34 veryclean
	make -C artifacts/fedora34 veryclean

	make -C buildenv/fedora35 veryclean
	make -C build/fedora35 veryclean
	make -C artifacts/fedora35 veryclean


#
# The 'all' target builds everything while trying to minimize
# disk space.
#

all : source

	make -C source pub

	make debian11
	make -C artifacts/debian11 pub
	make -C buildenv/debian11 veryclean
	make -C build/debian11 veryclean

	make mint20
	make -C artifacts/mint20 pub
	make -C buildenv/mint20 veryclean
	make -C build/mint20 veryclean

	make ubuntu20
	make -C artifacts/ubuntu20 pub
	make -C buildenv/ubuntu20 veryclean
	make -C build/ubuntu20 veryclean

	make fedora34
	make -C artifacts/fedora34 pub
	make -C buildenv/fedora34 veryclean
	make -C build/fedora35 veryclean

	make fedora35
	make -C artifacts/fedora35 pub
	make -C buildenv/fedora35 veryclean
	make -C build/fedora35 veryclean



debian11 :
	make -C build/debian11 all # perform ./mach build && ./mach package
	make -C artifacts/debian11 all # make final artifacts

mint20 :
	make -C build/mint20 all # perform ./mach build && ./mach package
	make -C artifacts/mint20 all # make final artifacts

ubuntu20 :
	make -C build/ubuntu20 all # perform ./mach build && ./mach package
	make -C artifacts/ubuntu20 all # make final artifacts

fedora34 :
	make -C build/fedora34 all # perform ./mach build && ./mach package
	make -C artifacts/fedora34 all # make final artifacts

fedora35 :
	make -C build/fedora35 all # perform ./mach build && ./mach package
	make -C artifacts/fedora35 all # make final artifacts



#
# Keeping ./version up to date.
#

check :
	@python3 scripts/update-version.py


#
# Making the source tarball
#

source :
	make -C source all


#
# buildenv: Creating build environment and performing the build
#

buildenv :

	make -C buildenv/debian11 build
	make -C buildenv/mint20 build
	make -C buildenv/ubuntu20 build
	make -C buildenv/fedora34 build
	make -C buildenv/fedora35 build


no-cache :

	make -C buildenv/debian11 no-cache
	make -C buildenv/mint20 no-cache
	make -C buildenv/ubuntu20 no-cache
	make -C buildenv/fedora34 no-cache
	make -C buildenv/fedora35 no-cache


#
# pub
#

pub :

	make -C source pub
	make -C artifacts/debian11 pub
	make -C artifacts/mint20 pub
	make -C artifacts/ubuntu20 pub
	make -C artifacts/fedora34 pub
	make -C artifacts/fedora35 pub


#
# zapping all docker state..
#

purge : prune
prune :
	$(docker) system prune --all --force


#
# init: run bootstrap on local machine
#

init :
	bash scripts/mozfetch.sh
