.PHONY : all clean veryclean build shell

version_file=../../version
version:=$(shell cat $(version_file))
release_file=../../release
release:=$(shell cat $(release_file))

tag=bs4-buildenv-$(distro)


all : build

clean :
	sudo rm -rf work

veryclean : clean
	rm -f typescript



work : ../../source/librewolf-$(version)-$(shell cat ../../source/source_release).source.tar.gz
	make clean
	mkdir work
	(cd work && tar xf ../$<)
	cp -v ../../assets/build-librewolf.py work/librewolf-$(version)



build : work
	script -e -c "time docker run --rm --privileged -v $(shell pwd)/work:/work:rw $(tag) python3 /work/librewolf-$(version)/build-librewolf.py $(version)"
	#cp -v work/librewolf-$(version)/obj-x86_64-pc-linux-gnu/dist/librewolf-$(version).en-US.linux-x86_64.tar.bz2 ../../artifacts/$(distro)
	cp -v work/librewolf-$(version)/obj-*/dist/librewolf-$(version).en-US.linux-x86_64.tar.bz2 ../../artifacts/$(distro)




shell : work
	-docker run -it --rm -v $(shell pwd)/work:/work:rw $(tag) bash

shell-no-work :
	-docker run -it --rm $(tag) bash


