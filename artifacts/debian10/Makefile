distro=debian10

include ../../assets/Makefile.includes

.PHONY : all clean veryclean

version_file=../../version
version:=$(shell cat $(version_file))

tag=librewolf/bs4-buildenv-$(distro)

build-artifact=librewolf-$(version).en-US.linux-x86_64.tar.bz2
output=librewolf-$(version).en-US.$(distro)-x86_64.deb

all : $(output)

clean :
	$(rm) -rf work $(output)

veryclean : clean
	rm -f $(build-artifact)

$(output) : $(build-artifact)
	$(rm) -rf work
	mkdir work
	(cd work && tar xf ../$(build-artifact))
	cp -v build-deb.sh work
	$(docker) run --rm --privileged -v $(shell pwd)/work:/work:rw $(tag) bash build-deb.sh $(version)
	cp -v work/librewolf.deb $(output)

$(build-artifact) :
	@echo "Error: Please use 'make $(distro)' at top-level to build first."
	false
