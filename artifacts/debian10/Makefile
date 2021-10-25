.PHONY : all clean veryclean

version_file=../../version
version:=$(shell cat $(version_file))

all : input

clean :

veryclean : clean
	rm -f firefox-$(version).en-US.linux-x86_64.tar.bz2

input : firefox-$(version).en-US.linux-x86_64.tar.bz2

firefox-$(version).en-US.linux-x86_64.tar.bz2 : ../../build/debian10/work/librewolf-$(version)/obj-x86_64-pc-linux-gnu/dist/firefox-$(version).en-US.linux-x86_64.tar.bz2
	cp -v $< .
