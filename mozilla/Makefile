.PHONY : help all veryclean

help :
	@echo "use: make [all] [veryclean]"
	@echo ""
	@echo "  all                    - pull the latest changes from mercurial."
	@echo "  veryclean              - remove the actual 'mozilla-unified' folder."
	@echo "  STRING=something find  - find 'something' in all files."
	@echo ""
	@echo "note: 'make all' will clone the full mozilla repo if it"
	@echo "      doesn't exist already."

all : mozilla-unified
	(cd mozilla-unified && hg pull)
	(cd mozilla-unified && hg update)

mozilla-unified :
	hg clone https://hg.mozilla.org/mozilla-unified
	(cd mozilla-unified && hg update)

veryclean :
	rm -rf mozilla-unified

find :
	find mozilla-unified -type f | xargs grep ${STRING}
