RUSTC := rustc
CC := gcc
CARGO := rustup run nightly cargo

SRCS = $(shell find . -maxdepth 1 -regextype posix-extended -regex '.+\.(c|rs)$$')
CRATES = $(shell find * -maxdepth 0 -type d)
OBJS = $(addsuffix .o,$(basename $(SRCS)))
OBJS += $(addsuffix .a,$(addprefix lib,$(CRATES)))

default: main

main: $(OBJS)
	$(CC) -o $@ $^

%.o: %.rs
	$(RUSTC) --emit=obj --crate-type=staticlib -o $@ $^

%.o: %.c
	$(CC) -c -o $@ $^

lib%.a: %/target/release/lib%.a
	cp $^ $@

lib%.a: %
	cd $^ && $(CARGO) build --release
	cp $^/target/release/$@ $@

clean:
	rm $(OBJS)

.PHONY: clean

