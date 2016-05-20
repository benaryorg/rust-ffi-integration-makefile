RUSTC := rustc
RUSTFLAGS := --emit=obj --crate-type=staticlib

CC := gcc
CFLAGS :=

LD := gcc
LDFLAGS :=

CARGO := rustup run nightly cargo
CARGOFLAGS := --release

SRCS = $(shell find . -maxdepth 1 -regextype posix-extended -regex '.+\.(c|rs)$$')
CRATES = $(shell find * -name Cargo.toml -type f -exec dirname "{}" \;)
OBJS = $(addsuffix .o,$(basename $(SRCS)))
OBJS += $(addsuffix .a,$(addprefix lib,$(CRATES)))

default: main

main: $(OBJS)
	@printf "[%6s] %s\n" "LD" "$@" 
	@$(LD) $(LDFLAGS) -o $@ $^

%.o: %.rs
	@printf "[%6s] %s\n" "RUSTC" "$@" 
	@$(RUSTC) $(RUSTFLAGS) -o $@ $^

%.o: %.c
	@printf "[%6s] %s\n" "CC" "$@" 
	@$(CC) $(CFLAGS) -c -o $@ $^

lib%.a: %
	@printf "[%6s] %s\n" "CARGO" "$@" 
	@cd $^ && $(CARGO) build --quiet $(CARGOFLAGS)
ifneq (,$(findstring "--release",$(CARGOFLAGS)))
	@cp $^/target/debug/$@ $@
else
	@cp $^/target/release/$@ $@
endif

clean: $(addsuffix -clean,$(CRATES))
	rm -f $(OBJS)

%-clean: %
	@printf "[%6s] %s\n" "CLEAN" "$^" 
	@cd $^ && cargo clean

.PHONY: clean

