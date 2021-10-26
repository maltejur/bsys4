.PHONY : all clean veryclean

version_file=../../version
version:=$(shell cat $(version_file))

all : input

clean :

veryclean : clean
	rm -f firefox-$(version).en-US.linux-x86_64.tar.bz2

input : firefox-$(version).en-US.linux-x86_64.tar.bz2

firefox-$(version).en-US.linux-x86_64.tar.bz2 :
	@echo "Error: Please use 'make debian10' at top-level to build first."
	false
