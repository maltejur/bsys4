.PHONY : all help clean veryclean check update build buildenv source artifacts

version_file=./version
version:=$(shell cat $(version_file))

all : source buildenv build artifacts

help :
	@echo "use: make [all] [help] [clean] [veryclean] [check|update] [build] [buildenv]"
	@echo ""
	@echo "  'update' or 'check' - Check for new Firefox version and "
	@echo "                        update the './version"

clean :
	make -C source clean
	make -C build/debian10 clean

veryclean : clean
	make -C source veryclean
	make -C build/debian10 veryclean

#
# Keeping ./version up to date.
#

check : update
update :
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
# build: Building the mozilla tree and artifact
#

source/librewolf-$(version).source.tar.gz :
	make -C source all

build : source/librewolf-$(version).source.tar.gz
	make -C build/debian10 build

#
# artifacts
#

artifacts : 
	make -C artifacts all

