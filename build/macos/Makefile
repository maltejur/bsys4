# variable: which distro we want to build this?
distro=macos

docker=sudo docker
rm=sudo rm
mkdir=sudo mkdir
tar=sudo tar
cp=sudo cp -v
chown=sudo chown

.PHONY : help all clean veryclean build shell

version_file=../../version
version:=$(shell cat $(version_file))

# note: crosscompile host distro = debian11
tag=librewolf/bs4-buildenv-debian11




help :
	@echo "Use: make [all] [clean] [veryclean] [shell]"
	@echo ""
	@echo "   all       -  build librewolf with ./mach build"
	@echo "   clean     -  remove 'work' folder"
	@echo "   veryclean -  clean and remove downloaded archive"
	@echo "   shell     -  run a shell in the work folder"



clean :
	$(rm) -rf work

veryclean : clean



work :   ../../source/librewolf-$(version).source.tar.gz build.sh mozconfig
	$(rm) -rf work
	$(mkdir) work
	(cd work && $(tar) xf ../../../source/librewolf-$(version).source.tar.gz && cd ..)
	$(cp) build.sh work
	$(cp) mozconfig work/librewolf-$(version)

	$(mkdir) work/librewolf-$(version)/lw-assets/macos
	(cd work/librewolf-$(version)/lw-assets/macos && sudo wget https://github.com/phracker/MacOSX-SDKs/releases/download/11.3/MacOSX11.3.sdk.tar.xz)
	(cd work/librewolf-$(version)/lw-assets/macos && sudo tar xf MacOSX11.3.sdk.tar.xz)

	$(chown) -R root:root work

all : work
	$(docker) pull $(tag)
	$(docker) run --rm --privileged -v $(shell pwd)/work:/work:rw $(tag) ./build.sh

shell : work
	$(docker) pull $(tag)
	$(docker) run -it --rm --privileged -v $(shell pwd)/work:/work:rw $(tag) bash
