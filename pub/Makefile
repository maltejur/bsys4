.PHONY : help fresh

version_file=../version
version:=$(shell cat $(version_file))

help :
	@echo "use: make [help] [fresh]"

fresh :
	(cd librewolf/librewolf-$(version) && rm -f sha256sums.txt)
	(cd librewolf/librewolf-$(version) && sha256sum * > sha256sums.txt)
	scp -r librewolf/librewolf-$(version) nine:pub/pub/librewolf
