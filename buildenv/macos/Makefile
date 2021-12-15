distro=macos

.PHONY : all clean veryclean build no-cache upload push

tag=bs4-buildenv-$(distro)


all : build

clean :
	rm -f mozconfig

veryclean : clean
	-$(docker) rmi $(tag)

build :
	cp -v ../../scripts/mozconfig.osx-cross mozconfig
	sudo rm -rf work
	mkdir work
	cp -v ../../cross-assets/MacOSX10.12.sdk.tar.xz .
	(cd work && tar xf ../MacOSX10.12.sdk.tar.xz)
	sudo script -e -c "time docker build -t $(tag) ."

no-cache :
	cp -v ../../scripts/mozconfig.osx-cross mozconfig
	sudo rm -rf work
	mkdir work
	cp -v ../../cross-assets/MacOSX10.12.sdk.tar.xz .
	(cd work && tar xf ../MacOSX10.12.sdk.tar.xz)
	sudo script -e -c "time docker build --no-cache -t $(tag) ."

upload : push

push : build
	sudo docker push $(tag)

shell : 
	-sudo docker run -it --rm --privileged $(tag) bash
