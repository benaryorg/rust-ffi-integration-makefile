#![feature(lang_items)]
#![no_std]

mod hello;

#[no_mangle]
pub extern "C" fn foo() -> *const u8
{
	let s = hello::hello();

	s.unwrap_or("Nothing\0").as_ptr()
}

#[lang = "eh_personality"]
extern "C" fn eh_personality()
{
}

#[lang = "panic_fmt"]
fn panic_fmt() -> !
{
	loop {}
}

