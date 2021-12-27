.PHONY : all clean veryclean pub shell

version_file=../../version
version:=$(shell cat $(version_file))
release_file=../../release
release:=$(shell cat $(release_file))

tag=bs4-buildenv-$(distro)

build-artifact=librewolf-$(version).en-US.linux-x86_64.tar.bz2
output=librewolf-$(version)-$(release).en-US.$(distro).x86_64.deb

all : $(output)

clean :
	sudo rm -rf work

veryclean : clean
	rm -f $(build-artifact) $(output) *.deb

pub : $(output)
	-mkdir -p ../../pub/librewolf/librewolf-$(version)
	cp -v $(output) ../../pub/librewolf/librewolf-$(version)

$(output) : work
	docker run --rm -v $(shell pwd)/work:/work:rw $(tag) bash build-deb.sh $(version) $(release)
	cp -v work/librewolf.deb $(output)

work : $(build-artifact)
	make clean
	mkdir work
	(cd work && tar xf ../$(build-artifact))
	cp -v ../../scripts/build-deb.sh work
	cp -v ../../scripts/start-librewolf.desktop.in work
	(cd work && sed "s/MYDIR/\/usr\/share\/librewolf/g" < start-librewolf.desktop.in > start-librewolf.desktop)

$(build-artifact) :
	@(echo "Error: Please use 'make $(distro)' at top-level to build first." && false)


shell : work
	docker pull $(tag)
	docker run -it --rm -v $(shell pwd)/work:/work:rw $(tag) bash
