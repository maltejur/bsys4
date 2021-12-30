.PHONY : all help clean veryclean pub
version_file=../version
version:=$(shell cat $(version_file))
release_file=../release
release:=$(shell cat $(release_file))
source_release:=$(shell cat ./source_release)

all : source_release librewolf-$(version)-$(source_release).source.tar.gz

#
#librewolf-$(version)-$(release).source.tar.gz : source_release librewolf-$(version)-$(source_release).source.tar.gz
#	cp -v librewolf-$(version)-$(source_release).source.tar.gz $@
#

help : source_release 
	@echo "Use: make [all] [clean] [veryclean] [pub]"
	@echo ""
	@echo "  all           - build librewolf-$(version)-$(source_release).source.tar.gz"
	@echo "  clean         - remove all source trees and other cruft"
	@echo "  veryclean     - same as clean, but also remove source archives"
	@echo "  pub           - copy Libewolf source to pub folder"

clean : source_release 
	rm -f librewolf-$(version)-$(source_release).source.tar.gz

veryclean : clean

librewolf-$(version)-$(source_release).source.tar.gz : source_release 
	wget -q -O librewolf-$(version)-$(source_release).source.tar.gz "https://gitlab.com/librewolf-community/browser/source/-/jobs/artifacts/main/raw/librewolf-$(version)-$(source_release).source.tar.gz?job=build-job"


pub : 
	@echo "note: Source archive not distributed."

source_release :
	wget -q -O $@ "https://gitlab.com/librewolf-community/browser/source/-/raw/main/release"
