.PHONY : all help clean veryclean prune buildenv-all buildenv-no-cache

all: buildenv-all

help:
	@echo "use: make [all] [clean] [veryclean] [prune]"
	@echo "          [buildenv-all] [buildenv-no-cache]"

clean:
veryclean:

prune :
	sudo docker system prune --all --force

#
# create build environment docker images.
#

buildenv-all :
	make -C buildenv/debian10 all

buildenv-no-cache :
	make -C buildenv/debian10 no-cache
