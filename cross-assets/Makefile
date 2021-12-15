osx_sdk_file=MacOSX10.12.sdk.tar.xz

all : $(osx_sdk_file)

$(osx_sdk_file) :
	wget https://github.com/phracker/MacOSX-SDKs/releases/download/11.3/MacOSX10.12.sdk.tar.xz

clean :
	rm -f $(osx_sdk_file)

veryclean : clean
