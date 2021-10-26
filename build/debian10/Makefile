.PHONY : all clean veryclean build

version_file=../../version
version:=$(shell cat $(version_file))

tag=librewolf/bs4-buildenv-debian10

docker=sudo docker
rm=sudo rm
mkdir=sudo mkdir
tar=sudo tar
cp=sudo cp -v
chown=sudo chown

all : build

clean :
	$(rm) -rf work

veryclean : clean
	-$(docker) rmi $(tag)

work : ../../source/librewolf-$(version).source.tar.gz
	$(rm) -rf work
	$(mkdir) work
	(cd work && $(tar) xf ../$< && cd ..)
	$(chown) -R root:root work

build : work
	$(docker) pull $(tag)
	$(docker) run --rm --privileged -v $(shell pwd)/work:/work:rw $(tag) python3 /work/librewolf-$(version)/build-librewolf.py
	cp -v work/librewolf-$(version)/obj-x86_64-pc-linux-gnu/dist/firefox-$(version).en-US.linux-x86_64.tar.bz2 ../../artifacts/debian10
