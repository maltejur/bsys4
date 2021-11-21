# variable: which distro we want to build this?
distro=debian11

# .. the rest is the same for all distro's

docker=sudo docker
rm=sudo rm
mkdir=sudo mkdir
tar=sudo tar
cp=sudo cp -v
chown=sudo chown

.PHONY : help all clean veryclean build shell

version_file=../../version
version:=$(shell cat $(version_file))

tag=librewolf/bs4-buildenv-$(distro)


help :
	@echo "Use: make [all] [clean] [veryclean] [shell]"
	@echo ""
	@echo "   all       -  build librewolf with ./mach build"
	@echo "   clean     -  remove 'work' folder"
	@echo "   veryclean -  clean and remove downloaded archive"
	@echo "   shell     -  run a shell in the work folder"

# FIXME SOON by running 'make check'
version:=94.0.2

clean :
	$(rm) -rf work

veryclean : clean
	rm -f librewolf-$(version).source.tar.gz

librewolf-$(version).source.tar.gz :
	wget -O librewolf-$(version).source.tar.gz https://gitlab.com/stanzabird/source/-/jobs/artifacts/main/raw/librewolf-$(version).source.tar.gz?job=build-job

work : librewolf-$(version).source.tar.gz
	$(rm) -rf work
	$(mkdir) work
	(cd work && $(tar) xf ../$< && cd ..)
	$(cp) build.sh work
	$(chown) -R root:root work

all : work
	$(docker) pull $(tag)
	$(docker) run --rm --privileged -v $(shell pwd)/work:/work:rw $(tag) ./build.sh

shell : work
	$(docker) pull $(tag)
	$(docker) run -it --rm --privileged -v $(shell pwd)/work:/work:rw $(tag) bash
