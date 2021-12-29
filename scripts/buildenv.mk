.PHONY : all clean veryclean build no-cache upload push

tag=bs4-buildenv-$(distro)


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
	make -C ../bootstrap all
	cp ../../scripts/buildenv.sh .
	rm -rf mozilla-unified
	make mozilla-unified
	script -e -c "time docker build -t $(tag) ."
	rm -rf mozilla-unified

no-cache :
	make -C ../bootstrap all
	cp ../../scripts/buildenv.sh .
	rm -rf mozilla-unified
	make mozilla-unified
	sudo script -e -c "time docker build --no-cache -t $(tag) ."
	rm -rf mozilla-unified

upload : push

push : build
	docker push $(tag)

shell : 
	-docker run -it --rm $(tag) bash