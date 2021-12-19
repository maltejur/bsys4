.PHONY : help fresh
version_file=../version
version:=$(shell cat $(version_file))

host=nine
path=pub/pub/librewolf

help :
	@echo "use: make [help] [fresh]"

fresh :
	(cd librewolf/librewolf-$(version) && rm -f sha256sums.txt)
	(cd librewolf/librewolf-$(version) && sha256sum * > sha256sums.txt)
	scp -r librewolf/librewolf-$(version) $(host):$(path)
