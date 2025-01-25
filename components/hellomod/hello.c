#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>

static int __init hello_start( void )
{
    printk( KERN_INFO "Loading hello module...\n" );
    printk( KERN_INFO "Hello world\n" );
    return 0;
}

static void __exit hello_end( void )
{
    printk( KERN_INFO "Goodbye Mr.\n" );
}

module_init( hello_start );
module_exit( hello_end );

MODULE_LICENSE( "GPL" );
MODULE_AUTHOR( "Your Name" );
MODULE_DESCRIPTION( "A simple Hello World Linux module." );
