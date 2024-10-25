BINDIR := ${HOME}/.local/bin
TMPDIR ?= "/tmp"

CPPFLAGS = -Iinclude -Iinclude/ncursesw
LDFLAGS = -Llib
LIBS = "-lncursesw"

DLDIR = $(TMPDIR)/dl
SRC = $(TMPDIR)/src

all: tmux fish kak kak-lsp delta

libevent:
	pkg-config --exists libevent || sudo apt-get -y install libevent-dev

libncurses:
	pkg-config --exists ncurses || sudo apt-get -y install libncurses5-dev

tmux: libncurses libevent | $(DLDIR) $(SRC)
	wget --hsts-file= -nv https://github.com/tmux/tmux/releases/download/3.5a/tmux-3.5a.tar.gz -O $(DLDIR)/tmux.tar.gz \
	&& rm -rf $(SRC)/tmux-*/ \
	&& tar xzf $(DLDIR)/tmux.tar.gz -C $(SRC) \
	&& cd $(SRC)/tmux-*/ \
	&& ./configure -q \
	&& $(MAKE) -s \
	&& sudo $(MAKE) -s install

fish: libncurses | $(DLDIR) $(SRC)
	wget --hsts-file= -nv https://github.com/fish-shell/fish-shell/releases/download/3.4.1/fish-3.4.1.tar.xz -O $(DLDIR)/fish.tar.xz \
	&& tar xJf $(DLDIR)/fish.tar.xz -C $(SRC) \
	&& cd $(SRC)/fish-* \
	&& mkdir build && cd build \
	&& cmake .. \
	&& $(MAKE) -s \
	&& sudo $(MAKE) -s install

kak: | $(DLDIR) $(SRC)
	git clone --quiet https://github.com/mawww/kakoune $(SRC)/kakoune \
	&& cd $(SRC)/kakoune/ \
	&& curl -sL https://raw.githubusercontent.com/caksoylar/kakoune-smooth-scroll/master/revert_9787756.patch | git am \
	&& $(MAKE) -s \
	&& sudo $(MAKE) -s install

kak-lsp: | $(DLDIR) $(SRC) $(BINDIR)
	wget --hsts-file= -nv https://github.com/kakoune-lsp/kakoune-lsp/releases/download/v18.0.2/kakoune-lsp-v18.0.2-x86_64-unknown-linux-musl.tar.gz -O $(DLDIR)/kak-lsp.tar.gz \
	&& mkdir -p $(SRC)/kak-lsp $(BINDIR) \
	&& tar xzf $(DLDIR)/kak-lsp.tar.gz -C $(SRC)/kak-lsp \
	&& cp $(SRC)/kak-lsp/kak-lsp $(BINDIR)/

kak-tree-sitter: | $(BINDIR)
	wget --hsts-file= -nv https://github.com/hadronized/kak-tree-sitter/releases/download/ktsctl-v0.4.0/ktsctl.Linux-x86_64 -O $(BINDIR)/ktsctl \
	&& wget --hsts-file= -nv https://github.com/hadronized/kak-tree-sitter/releases/download/kak-tree-sitter-v0.6.0/kak-tree-sitter.Linux-x86_64 -O $(BINDIR)/kak-tree-sitter \
	&& chmod +x $(BINDIR)/ktsctl $(BINDIR)/kak-tree-sitter

delta:
	wget --hsts-file= -nv https://github.com/dandavison/delta/releases/download/0.18.2/git-delta_0.18.2_amd64.deb -O $(DLDIR)/git-delta.deb \
	&& sudo dpkg -i $(DLDIR)/git-delta.deb

$(DLDIR):
	mkdir -p $(DLDIR)

$(SRC):
	mkdir -p $(SRC)

$(BINDIR):
	mkdir -p $(BINDIR)

clean:
	rm -rf $(DLDIR) $(SRC)

.PHONY:
	libevent libncurses tmux fish kak kak-lsp kak-tree-sitter delta
