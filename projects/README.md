# `stellaris-lm3s-mcu`

cf. https://docs.rust-embedded.org/book/start/qemu.html

The "The Embedded Rust Book" for QEMU seems to provide 3 or more ways to start the non standard Rust program as an example, where in the example we're supposed to write a program for the LM3S6965, Cortex-M3 microcontroller from [TI](http://www.ti.com/product/LM3S6965). For `stellaris-lm3s-mcu`, I used the "Using `cargo-generate`" mthod, doing

```
cargo install cargo-generate
```

because running `cargo generate --help` said it wasn't installed or there wasn't the generate option, and then I did, in this current directory,

```
cargo generate --git https://github.com/rust-embedded/cortex-m-quickstart
```

It'd then prompt `Project Name` and I typed in the choice of name I had: `stellaris-lm3s-mcu`.

I had to install the following to the Rust toolchain:

```
$ rustup target add thumbv7m-none-eabi
```
otherwise, errors would occur.

Also for `cargo readobj` you'll need to install cargo-binutils. Get a list of what's installed like this:

```
$ cargo install --list
```

cf. https://github.com/rust-embedded/cargo-binutils the README.md for cargo-binutils suggest this as well
```
rustup component add llvm-tools-preview
```
otherwise, this error is obtained: 

```
Could not find tool: readobj
at: /home/topolo/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/x86_64-unknown-linux-gnu/bin/llvm-readobj
```

## References

Maybe this page helps to actually flash the MCU.
https://blog.knoldus.com/embedded-rust-build-flash-binary-to-stm32f3discovery/


