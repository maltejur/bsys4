.PHONY : help all clean veryclean

help :
	@echo "use: make [all] [clean] [veryclean]"

all : mozilla-unified
	(cd mozilla-unified && hg pull)
	(cd mozilla-unified && hg update)

mozilla-unified :
	hg clone https://hg.mozilla.org/mozilla-unified
	(cd mozilla-unified && hg update)

clean :

veryclean : clean
	rm -rf mozilla-unified
