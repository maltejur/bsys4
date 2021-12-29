.PHONY : all clean veryclean build shell

version_file=../../version
version:=$(shell cat $(version_file))

tag=bs4-buildenv-$(distro)


all : build

clean :
	sudo rm -rf work

veryclean : clean
	rm -f typescript



work : ../../source/librewolf-$(version).source.tar.gz
	make clean
	mkdir work
	(cd work && tar xf ../$<)
	cp -v work/librewolf-$(version)/lw-assets/build-librewolf.py work/librewolf-$(version)



build : work
	script -e -c "time docker run --rm --privileged -v $(shell pwd)/work:/work:rw $(tag) python3 /work/librewolf-$(version)/build-librewolf.py $(version)"
	cp -v work/librewolf-$(version)/librewolf-$(version).en-US.linux-x86_64.tar.bz2 ../../artifacts/$(distro)




shell : work
	-docker run -it --rm -v $(shell pwd)/work:/work:rw $(tag) bash

shell-no-work :
	-docker run -it --rm $(tag) bash

