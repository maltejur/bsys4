.PHONY : all clean veryclean build no-cache upload push

tag=librewolf/bsys4-buildenv-$(distro)


all : build

clean :
	rm -f buildenv.sh

veryclean : clean
	rm -rf mozilla-unified
	rm -f typescript

mozilla-unified :
	make -C ../../mozilla all
	cp -r ../../mozilla/mozilla-unified .

build :
	cp ../../scripts/buildenv.sh .
	rm -rf mozilla-unified
	make mozilla-unified
	script -e -c "time docker build -t $(tag) ."
	rm -rf mozilla-unified

no-cache :
	cp ../../scripts/buildenv.sh .
	rm -rf mozilla-unified
	make mozilla-unified
	sudo script -e -c "time docker build --no-cache -t $(tag) ."
	rm -rf mozilla-unified

push :
	docker push $(tag)

shell : 
	-docker run -it --rm $(tag) bash
