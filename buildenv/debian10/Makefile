tag=librewolf/bs4-buildenv-debian10

all : build

build :
	sudo docker build -t $(tag) .

no-cache :
	sudo docker build -t $(tag) .

upload : push

push : build
	sudo docker push $(tag)
