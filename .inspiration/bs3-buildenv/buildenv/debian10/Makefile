tag=librewolf/bs3-buildenv-debian10

all : build

build :
	sudo docker build -t $(tag) .

no-cache :
	sudo docker build -t $(tag) .

upload : push

push : build
	sudo docker push $(tag)
