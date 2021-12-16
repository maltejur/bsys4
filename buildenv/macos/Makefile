distro=macos

.PHONY : all clean veryclean build no-cache upload push

tag=bs4-buildenv-$(distro)


all : build

clean :
	rm -rf MacOSX10.12.sdk

veryclean : clean
	-$(docker) rmi $(tag)

build :
	make clean
	tar xf ../../cross-assets/MacOSX10.12.sdk.tar.xz
	sudo script -e -c "time docker build -t $(tag) ."

no-cache :
	make clean
	tar xf ../../cross-assets/MacOSX10.12.sdk.tar.xz
	sudo script -e -c "time docker build --no-cache -t $(tag) ."

upload : push

push : build
	sudo docker push $(tag)

shell : 
	-sudo docker run -it --rm --privileged $(tag) bash
