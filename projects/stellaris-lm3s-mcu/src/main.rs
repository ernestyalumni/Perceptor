// cf. https://docs.rust-embedded.org/book/start/qemu.html
// #![no-std] indiciates this program won't link to standard crate, std, but instead it'll link to
// its subset: the `core` crate.
#![no_std]
// #![no_main] indicates this program won't use standard main interface that most Rust programs
// use. The main (no pun intended) reason to go with no_main is that using main interface in no_std
// context requires nightly.
#![no_main]

// pick a panicking behavior
use panic_halt as _; // you can put a breakpoint on `rust_begin_unwind` to catch panics
// use panic_abort as _; // requires nightly
// use panic_itm as _; // logs messages over ITM; requires ITM support
// use panic_semihosting as _; // logs messages to the host stderr; requires a debugger

use cortex_m::asm;
use cortex_m_rt::entry;

// #[entry] is an attribute provided by the cortex-m-rt crate that's used to mark the entry point
// of the program. As we're not using the standard main interface we need another way to indicate
// the entry point of the program and that'd be #[entry]
#[entry]
// fn main() -> !. Our program will be the only process running on the target hardware so we don't
// want it to end! Use a divergent function (the -> ! bit in function signature) to ensure at
// compile time that'll be the case.
fn main() -> ! {
    asm::nop(); // To not have main optimize to abort in release mode, remove when you add code

    loop {
        // your code goes here
    }
}
