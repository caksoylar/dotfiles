root:
	make -f Makefile.root

local:
	mkdir -p $HOME/.local \
	&& cp Makefile.local $HOME/.local/Makefile \
	&& cd $HOME/.local \
	&& make

.PHONY:
	root local
