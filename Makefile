.PHONY : all help clean veryclean check update

version_file=./version
version:=$(shell cat $(version_file))

all :
	make -C source all

help :
	@echo "use: make [all] [help] [clean] [veryclean] [check|update]"
	@echo ""
	@echo "  'update' or 'check' - Check for new Firefox version and "
	@echo "                        update the './version"

clean :
	make -C source clean

veryclean :
	make -C source veryclean

check : update
update :
	@python3 update-version.py
