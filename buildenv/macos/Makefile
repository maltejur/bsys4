distro=macos
osx-sdk-file=MacOSX11.3.sdk.tar.xz
osx-sdk-dir=MacOSX11.3.sdk


.PHONY : all clean veryclean build no-cache upload push

tag=librewolf/bsys4-buildenv-$(distro)


all : build

clean :
	rm -rf $(osx-sdk-dir)

veryclean : clean

build :
	make clean
	tar xf ../../cross-assets/$(osx-sdk-file)
	sudo script -e -c "time docker build -t $(tag) ."

no-cache :
	make clean
	tar xf ../../cross-assets/$(osx-sdk-file)
	sudo script -e -c "time docker build --no-cache -t $(tag) ."

push : build
	sudo docker push $(tag)

shell : 
	-sudo docker run -it --rm --privileged $(tag) bash
