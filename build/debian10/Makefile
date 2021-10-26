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

work : ../../source/librewolf-$(version).source.tar.gz
	$(mkdir) work
	(cd work ; $(tar) xf ../$< && $(cp) ../build.py librewolf-$(version) ; cd ..)
	$(chown) -R root:root work

build : work
	$(docker) pull $(tag)
	$(docker) run --rm --privileged -v $(shell pwd)/work:/work:rw $(tag) python3 /work/librewolf-$(version)/build.py
