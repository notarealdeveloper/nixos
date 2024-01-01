PKG := hello-again

all: result

result:
	nix build

run:
	nix run

check:
	nix flake check

build:
	gcc -o $(PKG) $(PKG).c

install:
	mkdir -p $$out/bin
	install -t $$out/bin $(PKG)

clean:
	rm -v result

.PHONY: run install clean
