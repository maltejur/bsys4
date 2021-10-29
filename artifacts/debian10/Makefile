.PHONY : all clean veryclean

version_file=../../version
version:=$(shell cat $(version_file))

build-artifact=librewolf-$(version).en-US.linux-x86_64.tar.bz2

all : input

clean :

veryclean : clean
	rm -f $(build-artifact)

input : $(build-artifact)

$(build-artifact) :
	@echo "Error: Please use 'make debian10' at top-level to build first."
	false
