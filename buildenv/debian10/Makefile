.PHONY : all clean veryclean build no-cache upload push

tag=librewolf/bs4-buildenv-debian10
docker=sudo docker

all : build

clean :
veryclean : clean
	$(docker) rmi $(tag)

build :
	$(docker) build -t $(tag) .

no-cache :
	$(docker) build --no-cache -t $(tag) .

upload : push

push : build
	$(docker) push $(tag)
