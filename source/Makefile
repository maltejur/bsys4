.PHONY : all help clean veryclean pub
version_file=../version
version:=$(shell cat $(version_file))

all : librewolf-$(version).source.tar.gz

help :
	@echo "Use: make [all] [clean] [veryclean] [pub]"
	@echo ""
	@echo "  all           - build librewolf-$(version).source.tar.gz"
	@echo "  clean         - remove all source trees and other cruft"
	@echo "  veryclean     - same as clean, but also remove source archives"
	@echo "  pub           - copy Libewolf source to pub folder"

clean :
	rm -f librewolf-$(version).source.tar.gz

veryclean : clean

librewolf-$(version).source.tar.gz :
	wget -q -O librewolf-$(version).source.tar.gz https://gitlab.com/stanzabird/source/-/jobs/artifacts/main/raw/librewolf-$(version).source.tar.gz?job=build-job


pub : librewolf-$(version).source.tar.gz
	-mkdir -p ../pub/librewolf/librewolf-$(version)
	cp -v $< ../pub/librewolf/librewolf-$(version)

