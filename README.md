# What is this?

This repository stores a *Makefile* and an example program for linking Rust
programs (compiled as static libraries, provided as crates, managed using
cargo) and C programs seamlessly.
This support can also be extended to include assembly, making it suitable for
low-level development using Rust's *libcore*.

# How to use it?

Just adapt the Makefile to suit your needs:

- set the variables as needed
- add recipes for other filetypes
	- need to be added to the `find` command too

Then simply run

```bash
make
```

# License

This software is licensed under the MIT license.

