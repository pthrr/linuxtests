#![no_std]
#![no_main]

use kernel::prelude::*;

module! {
    type: HelloWorld,
    name: "hello_world",
    author: "Your Name",
    description: "A simple hello world kernel module",
    license: "GPL",
}

struct HelloWorld;

impl kernel::Module for HelloWorld {
    fn init(_module: &'static kernel::ThisModule) -> Result<Self> {
        pr_info!("Hello, World from Rust kernel module!\n");
        Ok(HelloWorld)
    }
}

impl Drop for HelloWorld {
    fn drop(&mut self) {
        pr_info!("Goodbye from Rust kernel module!\n");
    }
}
