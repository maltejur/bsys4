.PHONY : all clean veryclean pub shell

version_file=../../version
version:=$(shell cat $(version_file))
release_file=../../release
release:=$(shell cat $(release_file))

tag=bs4-buildenv-$(distro)

build-artifact=librewolf-$(version).en-US.linux-x86_64.tar.bz2
output=librewolf-$(version)-$(release).$(fc).x86_64.rpm

all : $(output)

clean :
	sudo rm -rf work

veryclean : clean
	rm -f $(build-artifact) $(output) *.rpm

pub : $(output)
	-mkdir -p ../../pub/librewolf/librewolf-$(version)
	cp -v $(output) ../../pub/librewolf/librewolf-$(version)

$(output) : work
	docker run --rm -v $(shell pwd)/work:/work:rw $(tag) bash build-rpm.sh $(version)
	cp -v work/$(output) $(output)

work : $(build-artifact)
	make clean
	mkdir work
	(cd work && tar xf ../$(build-artifact))
	cp -v ../../scripts/build-rpm.sh work
	cp -v ../../version work
	cp -v ../../release work
	cp -v ../../scripts/librewolf.spec work
	cp -v ../../scripts/start-librewolf.desktop.in work/librewolf
	cp -v ../../scripts/librewolf.ico work/librewolf
	rm -f work/librewolf/browser/features/proxy-failover@mozilla.com.xpi
	rm -f work/librewolf/pingsender
	rm -f work/librewolf/precomplete
	rm -f work/librewolf/removed-files


$(build-artifact) :
	@(echo "Error: Please use 'make $(distro)' at top-level to build first." && false)


shell : work
	docker run -it --rm -v $(shell pwd)/work:/work:rw $(tag) bash
